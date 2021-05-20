//
//  ContentView.swift
//  DrugCounterWatch Extension
//
//  Created by Abigail Aryaputra Sudarman on 25/02/21.
//

import SwiftUI


struct ContentView: View {
    
    
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    
    //Sort here
    
    
    var drugs: FetchedResults<Drug>
    
    var body: some View {
        
        Text("kosomg")
            .padding()
            .onAppear(perform: {
                print(drugs)
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
