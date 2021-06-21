//
//  DrugDetailView.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 07/12/20.
//

import SwiftUI
import CoreData

struct DrugDetailView: View {
    var drug: Drug?
    @State var isMorningNotificationActive = false
    @State var isNoonNotificationActive = false
    @State var isNightNotificationActive = false
    
    @State var rootIsActive: Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.managedObjectContext) private var viewContext
    
    //@StateObject var vm = DrugDetailViewModel()
    @FetchRequest(sortDescriptors: [])
    
    //Sort here
    
    var histories: FetchedResults<History>
    
    
    @FetchRequest(sortDescriptors: [])
    var notifications: FetchedResults<NotificationEntity>
    
    
    
    
    
    
    
    
    
    
    
    
    
    var body: some View {
        var filteredHistory = histories.filter { (item) -> Bool in
            var range = Date().startOfDay...Date().endOfDay
            return item.drugID == drug?.id?.uuidString && range.contains(item.timeTaken!)
        }
        
        var notificationList: [FetchedResults<NotificationEntity>.Element] = notifications.filter { (item) -> Bool in
            return item.drugName == drug?.name
        }
        
        var filterWithMorning = notificationList.filter { (filteredItem) -> Bool in
            return filteredItem.time == 8
        }
        
        var filterWithNoon = notificationList.filter { (filteredItem) -> Bool in
            return filteredItem.time == 12
        }
        
        var filterWithNight = notificationList.filter { (filteredItem) -> Bool in
            return filteredItem.time == 18
        }
        
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .frame(width: .infinity, height: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .ignoresSafeArea()
                .foregroundColor(Color(.themeDarkGray))
            
            HStack{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .font(.system(size: 35, weight: .semibold, design: .rounded))
                    
                })
            }.position(x: UIScreen.main.bounds.maxX - 40, y: UIScreen.main.bounds.minY + 20)
            
            
            
            VStack{
                Spacer()
                
                ZStack{
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .frame(width: UIScreen.main.bounds.maxX - 10, height: 80 , alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(.displayP3, white: 0.2, opacity: 1))
                HStack{
                    
                    VStack{
                        
                        Text("Morning")
                            .foregroundColor(.white)
                        Button(action: {
                            
                            if isMorningNotificationActive == true {
                                deleteNotification(identifier: filterWithMorning[0].requestIdentifier!)
                                isMorningNotificationActive.toggle()
                            } else {
                                
                                setNotification(hour: 8, drugName: (drug?.name!)!)
                                isMorningNotificationActive.toggle()
                            }

                        }, label: {
                            ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 80, height: 45, alignment: .center)
                                .foregroundColor(isMorningNotificationActive == true ? .red : Color(.themeDarkGray))
                              
                                Image(systemName: isMorningNotificationActive == true ? "bell.fill" : "bell.slash")
                                    .foregroundColor(.white)
                                    .scaleEffect(1.7)
                                    
                            }
                                
                        })
                       
                        //ONCHANGE IF ISMORNING ACTIVE add notif, if not delete notif..
                    }.padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    VStack{
                        
                        Text("Noon")
                            .foregroundColor(.white)
                        Button(action: {
                            
                            if isNoonNotificationActive == true {
                                deleteNotification(identifier: filterWithNoon[0].requestIdentifier!)
                                isNoonNotificationActive.toggle()
                            } else {
                                
                                setNotification(hour: 12, drugName: (drug?.name!)!)
                                isNoonNotificationActive.toggle()
                            }

                        }, label: {
                            ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 80, height: 45, alignment: .center)
                                .foregroundColor(isNoonNotificationActive == true ? .red : Color(.themeDarkGray))
                                Image(systemName: isNoonNotificationActive == true ? "bell.fill" : "bell.slash")
                                    .foregroundColor(.white)
                                    .scaleEffect(1.7)
                            }
                                
                        })
                       
                        //ONCHANGE IF ISMORNING ACTIVE add notif, if not delete notif..
                    }.padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    VStack{
                        
                        Text("Night")
                            .foregroundColor(.white)
                        Button(action: {
                            
                            if isNightNotificationActive == true {
                                deleteNotification(identifier: filterWithNight[0].requestIdentifier!)
                                isNightNotificationActive.toggle()
                            } else {
                                
                                setNotification(hour: 18, drugName: (drug?.name!)!)
                                isNightNotificationActive.toggle()
                            }

                        }, label: {
                            ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 80, height: 45, alignment: .center)
                                .foregroundColor(isNightNotificationActive == true ? .red : Color(.themeDarkGray))
                                Image(systemName: isNightNotificationActive == true ? "bell.fill" : "bell.slash")
                                    .foregroundColor(.white)
                                    .scaleEffect(1.7)
                            }
                                
                        })
                       
                        //ONCHANGE IF ISMORNING ACTIVE add notif, if not delete notif..
                    }.padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                }
                    
                }
                
                Spacer()
                ZStack{
                    getShape(shape: (drug?.shape)!, color: (drug?.color)!)
                        .scaleEffect(2)
                }
                HStack{
                    
                    Text((drug?.name)!)
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                    Spacer()
                }.padding(.horizontal, 15)
                HStack{
                    Text(getDosage(drugs: drug!))
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .light, design: .rounded))
                    Spacer()
                }.padding(.horizontal, 15)
                
                
                
                
                
                if filteredHistory.count < drug!.dailyIntake {
                    ProgressView("Progress", value: Float(filteredHistory.count), total: Float(drug!.dailyIntake)).foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .padding(.top, 25)
                        .padding(.horizontal, 25)
                    HStack{
                        Text("\(filteredHistory.count)")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                        
                        Spacer()
                        Text("out of")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                        Spacer()
                        Text("\(drug!.dailyIntake)")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                        
                    }.padding(.horizontal, 25)
                    .padding(.bottom, 25)
                    
                    
                } else {
                    Image("check")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    
                }
                
                
                
                
                
                
                Button(action: {
                    takePills(drugs: drug!)
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                        Text("Gulp")
                    }
                })
                
                
                
                DrugDetailListView(drugID: drug?.id?.uuidString)
                    .frame(width: UIScreen.main.bounds.maxX - 40, height: 200, alignment: .center)
                
                
                
              
                                .onAppear {
                                    //IF MORNING NOTIF != nil, ismoringnotif = true
                                    if filterWithMorning.count != 0 {
                                        isMorningNotificationActive = true
                                    }
                                    if filterWithNoon.count != 0 {
                                        isNoonNotificationActive = true
                                    }
                
                                    if filterWithNight.count != 0 {
                                        isNightNotificationActive = true
                                    }
                
                
                                }
                Spacer()
            }
            
        }.navigationTitle("").navigationBarHidden(true)
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            
            if(value.startLocation.x < UIScreen.main.bounds.maxX / 2 && value.translation.width > 75) {
                self.presentationMode.wrappedValue.dismiss()
            }
            
        }))
        
        
        
    }
    //--------------------------------------------------------------------------------------------------------
    
    
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
        print("notification set")
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
    
    func deleteNotification(identifier: String) {
        
        print("function run")
        
        
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
    
    
    
    
    
    
    
    
    
    
    
    func takePills(drugs: Drug) {
        
        var newPill = History(context: viewContext)
        newPill.drugID = drug?.id?.uuidString
        newPill.drugName = drugs.name
        newPill.amount = 1
        newPill.timeTaken = Date()
        
        
        saveContext()
        //   print(drug.histories as Any)
    }
    
    
}



