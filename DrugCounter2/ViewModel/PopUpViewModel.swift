//
//  PopUpViewModel.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 20/05/21.
//

import Foundation
import SwiftUI
import UserNotifications

class PopUpViewModel: ObservableObject{
    
    static let sharedInstance = PopUpViewModel()
    
    
    @Published var insertName: String? = ""
    @Published var selectedColor: String? = ""
    @Published var selectedShape: String? = ""
    @Published var dosage: String = ""
    @Published var dailyIntake: Int = 0
    @Published var isNotFilled: Bool? = false
    @Published var isExpanded: Bool? = false
    @Published var notificationHour: [Int] = []
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var cvm = ContentViewModel.sharedInstance

    
    
    
    
    
    //functions
    
    
    

    
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
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }

}
