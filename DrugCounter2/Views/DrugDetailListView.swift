//
//  DrugDetailListView.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 07/12/20.
//

import SwiftUI

struct DrugDetailListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var drugID: String?
    @ObservedObject var viewModel = DrugDetailListViewVM.sharedInstance
    @FetchRequest(sortDescriptors: [])
    
    //Sort here
    var histories: FetchedResults<History>
    
    
   
    var body: some View {
       
      
        
        var filteredHistories = histories.filter { (item) -> Bool in
            var range = Date().startOfDay...Date().endOfDay
            print(item.drugID)
            print(drugID)
            return item.drugID == drugID && range.contains(item.timeTaken!)
        }
        ScrollView{
        VStack{
            //TimeInterval might be not unique
            ForEach(filteredHistories) {item in
                
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: .infinity, height: 50, alignment: .center)
                            .foregroundColor(Color(.themeMediumGray))
                        HStack{
                        Text(dateToString(date: item.timeTaken!))
                            .foregroundColor(.white)
                        Spacer()
                        }.padding(.horizontal, 10)
                    }.onAppear {
                        print(item)
                    }
                }
            }
            
            
        }
        }
    }
    

}
class DrugDetailListViewVM: ObservableObject {
    static let sharedInstance = DrugDetailListViewVM()

  //  @Published var histories: FetchedResults<History>
}

struct DrugDetailListView_Previews: PreviewProvider {
    static var previews: some View {
        DrugDetailListView()
    }
}



extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}
