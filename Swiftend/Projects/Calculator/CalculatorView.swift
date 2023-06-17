import SwiftUI

struct CalculatorView: View {
    @State var values = CalculatorState(current: "", previous: "")
    @State var lastOpWasEqual = false
    
    func setCurrent(_ value: CalculatorButton) {
        if value.type != .number || values.current.count >= 8 { return }
        if values.current.count == 0 && value == .digit(.zero) { return }
        if lastOpWasEqual {
            values.current = ""
            lastOpWasEqual = false
        }
        values.current = values.current + value.title
    }
    
    func setOperand(_ value: CalculatorButton) {
        if value.type != .op { return }
        var shouldReset = true
        if !values.previous.isEmpty {
            calculate()
            shouldReset = false
        }
        values.operand = Operation(rawValue: value.title)
        values.previous = values.current
        if shouldReset {
            values.current = ""
        }
    }
    
    func invertNumber() {
        guard let fCurrent = Float(values.current) else { return }
        if fCurrent > 0 {
            values.current = "-\(values.current)"
            return
        }
        values.current = String(values.current.dropFirst())
    }
    
    func toPercent() {
        guard let fCurrent = Float(values.current) else { return }
        values.current = String(format:"%.2f", (fCurrent / 100.0))
    }
    
    func calculate() {
        guard let fCurrent = Float(values.current) else { return }
        guard let fPrevious = Float(values.previous) else { return }
        
        values.previous = values.current
        var result: Float = fCurrent
        
        switch values.operand {
        case .plus:
            result = fPrevious + fCurrent
        case .minus:
            result = fPrevious - fCurrent
        case .divide:
            result = fPrevious / fCurrent
        case .multiply:
            result = fPrevious * fCurrent
        default:
            return
        }
        
        values.current = result.stringify
        lastOpWasEqual = true
    }
    
    func clear() {
        if !values.current.isEmpty {
            values.current = ""
            return
        }
        
        values.current = ""
        values.previous = ""
        values.operand = nil
    }
    
    func handlePress(btn: CalculatorButton) {
        switch btn {
        case .decimal:
            setCurrent(btn)
        case .plusMinus:
            invertNumber()
        case .percent:
            toPercent()
        case .clear:
            clear()
        case .op:
            setOperand(btn)
        case .equal:
            calculate()
        default:
            setCurrent(btn)
            
        }
    }
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .plusMinus, .percent, .op(.divide)],
        [.digit(.seven), .digit(.eight), .digit(.nine), .op(.multiply)],
        [.digit(.four), .digit(.five), .digit(.six), .op(.minus)],
        [.digit(.one), .digit(.two), .digit(.three), .op(.plus)],
        [.digit(.zero), .decimal, .equal]
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
                                CalculatorButtonView(button: button,  handler: handlePress, values: $values)
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
}


struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}


extension Float {
    var stringify: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.7f", self)
    }
}
