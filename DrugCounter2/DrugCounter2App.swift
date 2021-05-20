//
//  DrugCounter2App.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 05/12/20.
//

import SwiftUI

@main
struct DrugCounter2App: App {
    let persistenceController = PersistenceController.sharedInstance

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
