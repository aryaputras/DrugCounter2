//
//  DrugDetailView.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 07/12/20.
//

import SwiftUI

struct DrugDetailView: View {
    var drug: Drug?
    @State var rootIsActive: Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.managedObjectContext) private var viewContext
    
   //@StateObject var vm = DrugDetailViewModel()
    @FetchRequest(sortDescriptors: [])
   
    //Sort here
    
    var histories: FetchedResults<History>
    
    
    
    
    
    
    
    
    
    
    
    
    
    var body: some View {
        var filteredHistory = histories.filter { (item) -> Bool in
            var range = Date().startOfDay...Date().endOfDay
            return item.drugID == drug?.id?.uuidString && range.contains(item.timeTaken!)
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
                    .frame(width: UIScreen.main.bounds.maxX - 40, height: 300, alignment: .center)
                
            }
            
        }.navigationTitle("").navigationBarHidden(true)
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
               
            if(value.startLocation.x < UIScreen.main.bounds.maxX / 2 && value.translation.width > 75) {
                       self.presentationMode.wrappedValue.dismiss()
                   }
                   
               }))
        
            
    
    }
    //--------------------------------------------------------------------------------------------------------
    
    
    
    
    
    
    
        
    
    func deleteDrugs(drug: Drug){
        viewContext.delete(drug)
        do{
            try viewContext.save()} catch {
                print("error")
            }
    }
    private func saveContext() {
        do {
            try  viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolvederror")
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



