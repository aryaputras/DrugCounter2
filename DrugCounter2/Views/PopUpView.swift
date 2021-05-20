//
//  PopUpView.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 07/12/20.
//

import SwiftUI
import UserNotifications

struct PopUpView: View {
    @ObservedObject var popUpViewModel: PopUpViewModel = PopUpViewModel.sharedInstance
//
//    @State var insertName: String
//    @State var selectedColor: String?
//    @State var selectedShape: String?
//    @State var dosage: String = ""
//    @State var dailyIntake: Int = 0
    @State var isNotFilled: Bool?
    @State var isExpanded: Bool? = false
//    @State var notificationHour: [Int] = []
//
//
    
    var paddingBottom: CGFloat = 15
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var cvm = ContentViewModel.sharedInstance
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(.white)
            
            VStack{
                HStack{
                    Button(action: {
                        cvm.isPresented = false
                    }, label: {
                        Text("Cancel")
                    })
                    Spacer()
                    Text("Add new drug")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        popUpViewModel.setNotification(hour: popUpViewModel.notificationHour[0], drugName: popUpViewModel.insertName!)
                        addDrug(name: popUpViewModel.insertName! , color: popUpViewModel.selectedColor ?? "White", shape: popUpViewModel.selectedShape ?? "Circle", intake: popUpViewModel.dailyIntake)
                        
                    }, label: {
                        Text("Save")
                    })
                }
                Spacer()
                ZStack{
                    TextField("Insert drug name...", text: Binding<String>(
                                get: {self.popUpViewModel.insertName ?? ""},
                                set: {self.popUpViewModel.insertName = $0}))
                        {
                        self.hideKeyboard()
                    }.padding()
                    
                  
                    
                    .border(isNotFilled == true ? Color.red : Color(.themeLightGray))
                    
                    if isNotFilled == true {
                        HStack{
                            Spacer()
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                            
                        }.padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
                    }
                    
                } .padding(.bottom, paddingBottom).padding(.top, 15)
                
                VStack{
                    Text("what's the pill color")
                    HStack{
                        ForEach(colorSelections) { color in
                            HStack{
                                ZStack{
                                    Circle()
                                        .foregroundColor(.gray)
                                        .frame(width: 52, height: 52, alignment: .center)
                                    Circle()
                                        
                                        .foregroundColor(color.color)
                                        
                                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .background(popUpViewModel.selectedColor == color.name ? RoundedRectangle(cornerRadius: 5).foregroundColor(Color(.themeLightGray)).frame(width: 55, height: 55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) : nil)
                                        .onTapGesture {
                                            popUpViewModel.selectedColor = color.name
                                            print(popUpViewModel.selectedColor as Any)
                                        }
                                    
                                    
                                    
                                }
                                
                                
                            }
                        }
                    }
                    .padding(.bottom, paddingBottom)
                }
                VStack{
                    Text("what's the pill shape")
                    HStack{
                        Ellipse()
                            .foregroundColor(getColor(color: popUpViewModel.selectedColor ?? "black") )
                            .frame(width: 60, height: 30, alignment: .center)
                            .background(popUpViewModel.selectedShape == "Ellipse" ? RoundedRectangle(cornerRadius: 5).foregroundColor(Color(.themeLightGray)).frame(width: 55, height: 55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) : nil)
                            .onTapGesture {
                                popUpViewModel.selectedShape = "Ellipse"
                            }
                        Circle()
                            .foregroundColor(getColor(color: popUpViewModel.selectedColor ?? "black") )
                            .frame(width: 40, height: 40, alignment: .center)
                            .background(popUpViewModel.selectedShape == "Circle" ? RoundedRectangle(cornerRadius: 5).foregroundColor(Color(.themeLightGray)).frame(width: 55, height: 55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) : nil)
                            .onTapGesture {
                                popUpViewModel.selectedShape = "Circle"
                            }
                        Capsule()
                            .foregroundColor(getColor(color: popUpViewModel.selectedColor ?? "black") )
                            .frame(width: 60, height: 30, alignment: .center)
                            .background(popUpViewModel.selectedShape == "Capsule" ? RoundedRectangle(cornerRadius: 5).foregroundColor(Color(.themeLightGray)).frame(width: 55, height: 55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) : nil)
                            .onTapGesture {
                                popUpViewModel.selectedShape = "Capsule"
                            }
                        
                        
                        
                    }
                }
                .padding(.bottom, paddingBottom)
                VStack{
                    Text("what's your daily intake")
                    HStack{
                        Button(action: {
                            if popUpViewModel.dailyIntake > 0 {
                                popUpViewModel.dailyIntake -= 1
                            } else {
                                popUpViewModel.dailyIntake -= 0
                            }
                            
                        }, label: {
                            Image(systemName: "minus")
                            
                        })
                        Text("\(popUpViewModel.dailyIntake)")
                        Button(action: {
                            popUpViewModel.dailyIntake += 1
                        }, label: {
                            Image(systemName: "plus")
                        })
                    } .padding(.bottom, paddingBottom)
                }
                HStack {
                    Button("Request Permission") {
                        // first
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("All set!")
                            } else if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                    }

                   
                }
                HStack{
                    Button("TEST"){
                        popUpViewModel.notificationHour.append(8)
                        
                    }
                    Button("Noon"){
                        popUpViewModel.notificationHour.append(12)
                        
                    }
                    Button("Night"){
                        popUpViewModel.notificationHour.append(18)
                        
                    }
                }
                Button(action: {
                    isExpanded = true
                }, label: {
                    
                    Text(isExpanded == false ? "more advanced options" :
                            "")
                        .foregroundColor(Color.gray)
                })
                if isExpanded == true {
                    VStack{
                        Text("what's your dosage per intake")
                        
                        TextField("in mg    (optional)", text: Binding<String>(
                                    get: {self.popUpViewModel.dosage ?? ""},
                                    set: {self.popUpViewModel.dosage = $0})){
                            self.hideKeyboard()
                        }
                            .padding()
                            .keyboardType(.numberPad)
                            .border(Color(.themeLightGray))
                            .frame(width: 200, height: 50, alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer()
                        
                        
                        
                    }
                }
            }.padding(.all, 15)
        }
    }
    
    
    
    
    
    
    
    //funcs
    
    

    private func saveContext() {
        do {
            try  viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolvederror")
        }
    }



    private func addDrug(name: String, color: String, shape: String, intake: Int) {
        withAnimation{
            if name.isEmpty == false {
                let newDrug = Drug(context: viewContext)
                newDrug.name = name
                newDrug.color = color
                newDrug.shape = shape
                newDrug.id = UUID()
                newDrug.dailyIntake = Int32(intake)
                newDrug.dosage = Int32(popUpViewModel.dosage) ?? 0




                //set Local notification
                saveContext()
                cvm.isPresented = false
            } else {
                isNotFilled = true
            }
        }
    }
}








//
//
//
//struct SelectTimeView: View {
//    @State var selectedTime: [Int] = []
//    var body: some View {
//        HStack{
//            Button("Morning"){
//                selectedTime.append(1)
//
//            }
//            Button("Noon"){
//                selectedTime.append(2)
//
//            }
//            Button("Night"){
//                selectedTime.append(3)
//
//            }
//        }
//    }
//}
//
//struct PopUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        PopUpView(insertName: PopUpViewModel.sharedInstance.insertName)
//    }
//}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
