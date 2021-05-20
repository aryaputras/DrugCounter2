//
//  UI.swift
//  DrugCounter
//
//  Created by Abigail Aryaputra Sudarman on 06/12/20.
//

import Foundation
import SwiftUI

extension UIColor {
    static var themeDarkGray: UIColor {
        return UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1.00)
    }
    static var themeLightGray: UIColor {
        return UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
    }
    
    static var themeMediumGray: UIColor {
        return UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00)
    }
    
}

struct ColorSelection: Identifiable {
    var id: UUID
    var color: Color
    var name: String
}
let colorSelections: [ColorSelection] = [
    ColorSelection(id: UUID(), color: Color.pink, name: "pink"),
    ColorSelection(id: UUID(), color: Color.blue, name: "blue"),
    ColorSelection(id: UUID(), color: Color.purple, name: "purple"),
    ColorSelection(id: UUID(), color: Color.white, name: "white"),
    ColorSelection(id: UUID(), color: Color.green, name: "green"),
    
]



struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {
        
    }
    
}


struct DrugShapes: View {
    var body: some View {
        var round = Circle().frame(width: 50, height: 50, alignment: .center)
        
        var capsule = RoundedRectangle(cornerRadius: 100)
            .frame(width: 100, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}


struct CompleteAnimationView {
    var body: some View {
        Image("check")
            .animation(.easeIn, value: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
}
