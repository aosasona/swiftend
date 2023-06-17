import SwiftUI

enum CalculatorButton: String {
    case clear = "AC"
    case plusMinus = "±"
    case percent = "%"
    case divide = "÷"
    case multiply = "×"
    case minus = "-"
    case plus = "+"
    case equal = "="
    case decimal = "."
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
    
    var colors: (fg: Color, bg: Color) {
        switch self {
        case .clear, .plusMinus, .percent:
            return (.black , Color(.systemGray4))
        case .divide, .plus, .minus, .multiply, .equal:
            return (.white , .orange)
        default:
            return (.white, Color(.darkGray))
        }
    }
}




struct CalculatorView: View {
    @State var values = CalculatorState(current: "", previous: "")
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                Text(values.current.isEmpty ? "0" : values.current)
                    .foregroundColor(.white)
                    .font(.system(size: 88, weight: .light))
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                
                VStack(spacing: 12) {
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach (row, id: \.self) { button in
                                CalculatorButtonView(button: button, values: $values)
                            }
                        }
                    }
                }
            }
            .padding(Constants.padding)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        
    }
    
    let makeRows: (Int, Int) -> [String] = { ($0...$1).map { "\($0)" }}
}


struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
