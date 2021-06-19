//
//  HistoryView.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 07/12/20.
//

import SwiftUI
import UserNotifications
import CoreData
struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: #keyPath(NotificationEntity.time), ascending: true)])
    
    
    var notifications: FetchedResults<NotificationEntity>
    
    
    var body: some View {
        var notificationList: [FetchedResults<NotificationEntity>.Element] = notifications.filter { (item) -> Bool in
            return true
        }
        VStack{
            let uniqueNotif = getUniqueName(data: notificationList)
            
            ForEach(uniqueNotif, id: \.self) {item in
                
                VStack{
                    //MARK: -
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 200, height: 50, alignment: .center)
                            .foregroundColor(.gray)
                        VStack{
                            Text(item)
                            
                            //MARK: - USE PREDICATE / FILTER to display each notification data under a name.
                            let filteredNotif: [FetchedResults<NotificationEntity>.Element] = notificationList.filter { (itemc) -> Bool in
                                return itemc.drugName == item
                                
                            }
                            
                            //FILTER WITH TIME 8
                            var filterWithMorning = filteredNotif.filter { (filteredItem) -> Bool in
                                return filteredItem.time == 8
                            }
                            //FILTER WITH TIME 12
                            var filterWithNoon = filteredNotif.filter { (filteredItem) -> Bool in
                                return filteredItem.time == 12
                            }
                            //FILTER WITH TIME 18
                            var filterWithNight = filteredNotif.filter { (filteredItem) -> Bool in
                                return filteredItem.time == 18
                            }
                            
                            
                            ZStack{
                                HStack{
                                    
                        //MARK: - Kalo buttonnya off di klik lagi jadi apa? apakah write notification baru 
                                    //DISPLAY THE HOUR
                                    
                                    
                                    //IF filtered notif 8 = empty, return rect with gray color
                                    ZStack{
                                    Rectangle()
                                        .frame(width: 50, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(filterWithMorning.count == 0 ? .black : .green)
                                        .onTapGesture {
                                            if filterWithMorning != nil {
                                                deleteNotification(identifier: filterWithMorning[0].requestIdentifier!)
                                            } else {
                                                setNotification(hour: 8, drugName: filterWithMorning[0].drugName!)
                                            }
                                        }
                                        Text("8")
                                    }
                                    
                                    //IF filtered notif 12 = empty , return rect with gray color
                                    
                                    
                                    ZStack{
                                    Rectangle()
                                        .frame(width: 50, height: 25, alignment: .center)
                                        .foregroundColor(filterWithNoon.count == 0 ? .black : .green)
                                        .onTapGesture {
                                            if filterWithMorning != nil {
                                                deleteNotification(identifier: filterWithNoon[0].requestIdentifier!)
                                            }
                                        }
                                        Text("12")
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    //if filtered notif 18 = empty, return rect with gray color
                                    
                                    ZStack{
                                    Rectangle()
                                        .frame(width: 50, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(filterWithNight.count == 0 ? .black : .green)
                                        .onTapGesture {
                                            if filterWithMorning != nil {
                                                deleteNotification(identifier: filterWithNight[0].requestIdentifier!)
                                            }
                                        }
                                
                                    Text("18")
                                }
                                    
                                }
                                
                            }
                        }
                    }
                }.onAppear {
                    print(uniqueNotif)
                }
            }
            
            
        }
    }
    
    func getNotification(){
        let center = UNUserNotificationCenter.current()
        center.getDeliveredNotifications { (notification) in
            print(notification)
        }
    }
    
    
    
    
    
    
    
    func clearNotification(){
        //DELETE NOTIFICATION
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        
        
        //DELETE NOTIFICATIONDATA in CD
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "NotificationEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        
        do {
            try  viewContext.persistentStoreCoordinator?.execute(deleteRequest, with: viewContext)
        } catch let error as NSError {
            // TODO: handle the error
        }
        
        
        
    }
    
    
    
    
    
    func deleteNotification(identifier: String) {
        
        print("function run")
        print(identifier)
        
        //deletenotification
        let center = UNUserNotificationCenter.current()
        
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        center.removeDeliveredNotifications(withIdentifiers: [identifier])
        
        
        
        //delete notificationData
        let request = NSFetchRequest<NotificationEntity>(entityName: "NotificationEntity")
        request.predicate = NSPredicate(format:"requestIdentifier = %@", identifier)
        let result = try? viewContext.fetch(request)
        let resultData = result as! [NotificationEntity]
        
        for object in resultData {
            viewContext.delete(object)
        }
        
        do {
            try viewContext.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    func getUniqueName(data: [FetchedResults<NotificationEntity>.Element]) -> [String]{
        var uniqueDrugName: [String] = []
        for i in data {
            uniqueDrugName.append(i.drugName!)
        }
        //  uniqueDrugName.uniqueElements()
        return uniqueDrugName.uniqueElements()
    }
    func saveNotificationData(drugName: String, hour: Int, identifier: String){
       let newNotification = NotificationEntity(context: viewContext)
        newNotification.drugName = drugName
        newNotification.time = Int32(hour)
        newNotification.requestIdentifier = identifier

        //set Local notification
    //    print(drugName + "\(hour)" + identifier.uuidString)
        saveContext()
    }
    private func saveContext() {
        do {
            try  viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolvederror")
        }
    }
    
     func setNotification(hour: Int, drugName: String){
    
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

     
        
        dateComponents.hour = hour
        //Change minutes based on time to test the notification
        dateComponents.minute = 36


        // Create the trigger as a repeating event.

        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "its time to take your \(drugName)"
        content.sound = UNNotificationSound.default
            
        // show this notification five on the date

        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)

        // choose a random identifier
            let uuid = UUID()
        let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
            
            saveNotificationData(drugName: drugName, hour: hour, identifier: uuid.uuidString)
           
            
        

     }
    
}





struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
extension Array where Element: Hashable {
    func unsortedUniqueElements() -> [Element] {
        let set = Set(self)
        return Array(set)
    }
    func uniqueElements() -> [Element] {
        var seen = Set<Element>()
        
        return self.compactMap { element in
            guard !seen.contains(element)
            else { return nil }
            
            seen.insert(element)
            return element
        }
    }
}
