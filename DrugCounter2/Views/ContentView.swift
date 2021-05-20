//
//  ContentView.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 05/12/20.
//

import SwiftUI
import CoreData

class ContentViewModel: ObservableObject {
  
    static let sharedInstance = ContentViewModel()
    @Published var isPresented: Bool = false
}


struct ContentView: View {
    @ObservedObject var cvm = ContentViewModel.sharedInstance
   // @State var isPresented: Bool?
//    @ObservedObject var cvm = ContentViewModel().sharedInstance
    @State private var rootIsActive: Bool = false
    
    var body: some View {
   
        NavigationView{
            VStack{
                
                HStack{
                    Image(systemName: "plus")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                    Spacer()
                    Text("My drugs")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        cvm.isPresented = true
                    }, label: {
                        Image(systemName: "plus")
                            .font(.system(size: 28))
                            
                    })
                }.padding(.horizontal, 20)
                .padding(.top, 5)
                
                
            ZStack{
                
                VStack{
                   
                    DrugSelectionView(rootIsActive: self.rootIsActive, searchText: ""
                                        )
                   
                
                   
                  
                    
                    
                }
                .navigationBarTitle("My drugs", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    cvm.isPresented = true
                }, label: {
                    Text("Add")
                }))
                
                if cvm.isPresented == true {
                    ZStack{
                        BlurView(style: .systemUltraThinMaterial)
                            .onTapGesture {
                                cvm.isPresented = false
                            }
                            
                        
                        
                        PopUpView().frame(width: UIScreen.main.bounds.maxX - 50, height: UIScreen.main.bounds.maxY - 400, alignment: .center)
                        
                        
                    }
                }
            }.animation(.easeInOut(duration: 0.2))
            .navigationTitle("")
            .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.rootPresentationMode, self.$rootIsActive)
        
    
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
     
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search drugs"
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
}
