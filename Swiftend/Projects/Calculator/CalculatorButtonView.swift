import SwiftUI

struct CalculatorButtonView: View {
    var button: CalculatorButton
    @Binding var values: CalculatorState
    
    var body: some View {
        let colors = button.colors
        let size = getButtonSize()
        
        Button(button.title) { }
        .buttonStyle(GridButtonStyle(
            size: size,
            isZero: button == .zero,
            backgroundColor: colors.bg,
            foregroundColor: colors.fg )
        )
    }
    
    private func getButtonSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let buttonCount = 4.0
        let spacingCount = buttonCount + 1
        return (screenWidth - (spacingCount * Constants.padding)) / buttonCount
    }
}

struct GridButtonStyle: ButtonStyle {
    var size: CGFloat
    var isZero: Bool
    var backgroundColor: Color
    var foregroundColor: Color
    
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 32, weight: .medium))
            .frame(width: size, height: size)
            .frame(maxWidth: isZero ? .infinity : size, alignment: .leading)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .overlay {
                if configuration.isPressed {
                    Color(white: 1.0, opacity: 0.2)
                }
            }
            .clipShape(Capsule())
    }
}

struct CalculatorButtonView_Previews: PreviewProvider {
    struct Container: View {
        @State var val = CalculatorState.sample
        
        var body: some View {
            VStack {
                CalculatorButtonView(button: CalculatorButton.equal, values: $val)
            }
        }
    }
    
    static var previews: some View {
        Container()
    }
}
