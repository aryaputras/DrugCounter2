//
//  MainView.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 07/12/20.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Menu")
                    }

//                HistoryView()
//                    .tabItem {
//                        Image(systemName: "square.and.pencil")
//                        Text("History")
//                    }
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
