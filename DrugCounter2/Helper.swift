//
//  Helper.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 07/12/20.
//

import Foundation
import SwiftUI

func getColor(color: String) -> Color {
    var result: Color
    if color == "pink" {
        result = .pink
    } else if color == "blue" {
        result = .blue
    } else if color == "purple" {
        result = .purple
    } else if color == "green" {
        result = .green
    } else if color == "black" {
        result = .black
        } else {
        result = .white
    }
    return result
}
func getDosage(drugs: Drug) -> String{
    var result: String
    if drugs.dosage > 0 {
        result = "\(drugs.dosage) mg"
    } else {
        result = "1 Cap(s)"
    }
    return result
}
func dateToString(date: Date) -> String{
    let df = DateFormatter()
    df.dateFormat = "hh:mm:ss"
    let string = df.string(from: date)
    return string
}
func getShape(shape: String, color: String) -> some View {
    switch shape {
            case "Circle":
                return AnyView(VStack{ Circle()
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(getColor(color: color))
                })
            case "Capsule":
                return AnyView(VStack{ Capsule()
                    .frame(width: 80, height: 30, alignment: .center)
                    .foregroundColor(getColor(color: color))
                })
            case "Ellipse":
                return AnyView(VStack{ Ellipse()
                    .frame(width: 70, height: 30, alignment: .center)
                    .foregroundColor(getColor(color: color))
                })
    default:
        return AnyView(VStack{ Circle()
            .frame(width: 50, height: 50, alignment: .center)
            .foregroundColor(getColor(color: color))
        })
    
    }
}
