import Foundation
import SwiftUI

enum ButtonType {
    case number
    case op
    case clear
    case equal
}

enum Operation: String {
    case divide = "÷"
    case multiply = "×"
    case minus = "-"
    case plus = "+"
    
    var title: String { rawValue }
}

enum Digit: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    
    var title: String { rawValue }
}

enum CalculatorButton: Hashable {
    case digit(_ digit: Digit)
    case op(_ op: Operation)
    case clear
    case plusMinus
    case percent
    case equal
    case decimal
    
    var title: String {
        switch self {
        case .digit(let d):
            return d.title
        case .op(let op):
            return op.title
        case .plusMinus:
            return "±"
        case .percent:
            return "%"
        case .equal:
            return "="
        case .decimal:
            return "."
        case .clear:
            return "AC"
        }
    }
    
    var colors: (fg: Color, bg: Color) {
        switch self {
        case .clear, .plusMinus, .percent:
            return (.black , Color(.systemGray4))
        case .op(.divide), .op(.plus), .op(.minus), .op(.multiply), .equal:
            return (.white , .orange)
        default:
            return (.white, Color(.darkGray))
        }
    }
    
    var type: ButtonType {
        switch self {
        case .clear:
            return  .clear
        case .op(.divide), .op(.plus), .op(.minus), .op(.multiply):
            return  .op
        case .equal:
            return .equal
        default:
            return .number
        }
    }
}
