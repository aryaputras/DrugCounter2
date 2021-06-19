//
//  DrugSelectionView.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 06/12/20.
//

import SwiftUI
import CoreData


struct DrugSelectionView: View {
    
    @State var rootIsActive: Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
  
    @State var searchText: String
    @Environment(\.managedObjectContext) private var viewContext
    @State var isAlert: Bool = false
    @FetchRequest(sortDescriptors: [])
    
    //Sort here
    
    
    var drugs: FetchedResults<Drug>
    
    var filteredDrugs: [FetchedResults<Drug>.Element] {
        
        var x = drugs.filter { (item) -> Bool in
            
            if searchText != ""{
                return item.name!.lowercased().contains(searchText.lowercased())
            } else {
                return true
            }
        }
        
        return x
        
    }
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView{
            VStack{
                SearchBar(text: $searchText)
                if filteredDrugs.count == 0 {
                    ZStack{
                        Color(.themeLightGray)
                        .ignoresSafeArea()
                        .frame(width: UIScreen.main.bounds.maxX, height: UIScreen.main.bounds.maxY, alignment: .center)
                        VStack{
                            
                    Text("You have no drugs here. Add one by tapping the + button in top right corner")
                        .foregroundColor(Color(.themeMediumGray))
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .padding(.top, 50)
                        .padding(.horizontal, 25)
                        .multilineTextAlignment(.center)
                       
                            Spacer()
                        }
                    
                    }
                } else {

                LazyVGrid(columns: gridItemLayout){
                    
                    ForEach(filteredDrugs) {drug in
                       let hc = getHistoryCount(drugName: drug.id!.uuidString)
                        let di = drug.dailyIntake
                        ZStack{
                            
                            
//
                            ZStack{
//
//                                RoundedRectangle(cornerRadius: 40)
//
//                                    .foregroundColor(Color(.themeDarkGray))
//                                    .shadow(color: Color(.gray), radius: 7, x: 4, y: 4)
//
//
                                Image("interfacedark")
                                    .scaleEffect(1.05)
                                    
                                
                                
                                
                                
                                VStack{
                                    Spacer()
                                    getShape(shape: (drug.shape)!, color: (drug.color)!)
                                    
                                    HStack{
                                        Text(drug.name ?? "untitled")
                                            .foregroundColor(.white)
                                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                                            .padding(.horizontal, 10)
                                        
                                        
                                        Spacer()
                                    }
                                    HStack{
                                        Text(getDosage(drugs: drug))
                                            .foregroundColor(.white)
                                            .font(.system(size: 15, weight: .light, design: .rounded))
                                            .padding(.horizontal, 10)
                                        
                                       
                                        Spacer()
                                    }
                                    
                                    
                                    if hc < di {
                                    ProgressView(value: Float(hc), total: Float(di))
                                        .padding(.horizontal, 10)
                                    //change hard coded value to number of history taken
                                    
                                    } else {
                                        Image("check")
                                            .resizable()
                                            .frame(width: 50, height: 50, alignment: .center)
                                    }
                                    
                                    
                                    //                                    ProgressView("x", value: Float(getHistoryCount(drugName: drug.name!)), total: Float(drug.dailyIntake))
                                    //                                        .padding()
                                    
                                    
                                    
                                    Spacer(minLength: 50)
                                }
                            }.frame(width: 175, height: 220, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            NavigationLink(
                                destination: DrugDetailView(drug: drug, rootIsActive: self.rootIsActive),
                                label: {
                                    RoundedRectangle(cornerRadius: 40)
                                        .foregroundColor(Color(UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.01)))
                                }).frame(width: 145, height: 185, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            ZStack{
                                Circle()
                                    .foregroundColor(.red)
                                Image(systemName: "xmark")
                                    .font(.system(size: 17, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            
                            .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .offset(x: 80, y: -90)
                            .onTapGesture {
                                
                                isAlert = true
                             //   deleteDrugs(drug: drug)
                                
                            }
                            
                        }.alert(isPresented: $isAlert){
                            Alert(title: Text("Delete"), message: Text("are you sure wish to delete this drug?"), primaryButton: .destructive(Text("Delete"), action: {
                                deleteDrugs(drug: drug)
                            }), secondaryButton: .default(Text("Cancel")))
                        }
                        
                        
                    }
                    
                    
                } .padding(.horizontal, 10)
                }
            }
            
        }
    }
    func getHistoryCount(drugName: String) -> Int{
        //HISTORIES IS EMPTY
        var histories = [History]()
        let historyRequest: NSFetchRequest<History> = History.fetchRequest()
        
        do {
           histories = try viewContext.fetch(historyRequest)
        } catch {
            print("error in fetching history")
        }
        var filteredHistory = histories.filter { (item) -> Bool in
            let range = Date().startOfDay...Date().endOfDay
            return item.drugID == drugName && range.contains(item.timeTaken!)
        }
       // print(histories)
        let count = (filteredHistory.count) ?? 1
        return count
    }
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

  }

