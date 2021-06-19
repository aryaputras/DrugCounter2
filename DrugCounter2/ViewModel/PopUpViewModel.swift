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
    
    
    

    
    
    
    
    
    

}
