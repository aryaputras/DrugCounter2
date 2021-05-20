//
//  DrugCounter2App.swift
//  DrugCounterWatch Extension
//
//  Created by Abigail Aryaputra Sudarman on 25/02/21.
//

import SwiftUI

@main
struct DrugCounter2App: App {
    let persistenceController = PersistenceController.sharedInstance
    @SceneBuilder var body: some Scene {
        WindowGroup {
            
            NavigationView() {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
