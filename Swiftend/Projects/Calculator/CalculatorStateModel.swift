//
//  CalculatorModel.swift
//  Swiftend
//
//  Created by Ayodeji Osasona on 17/06/2023.
//

import Foundation

struct CalculatorState {
    var current: String
    var previous: String
    var operand: Operation?
}

extension CalculatorState {
    static let sample =  CalculatorState(current: "", previous: "")
}
