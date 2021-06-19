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
    return Image(shape + color).resizable()
        .frame(width: 130, height: 130, alignment: .center)
        .shadow(color: Color(hue: 0, saturation: 0, brightness: 0, opacity: 0.35), radius: 4, x: 0.0, y: 3)
}


