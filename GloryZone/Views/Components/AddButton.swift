import SwiftUI

struct AddButton: View {
    
    let title: String
    let disabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            TextCustom(text: title, size: 17, weight: .regular, color: .white.opacity(disabled ? 0.35 : 1))
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .disabled(disabled)
        .buttonStyle(CustomButton(disabled: disabled))
        .frame(height: 50)
        .clipShape(.rect(cornerRadius: 12))
    }
    
    private func disableTextOpacity() {
        
    }
}

#Preview {
    AddButton(title: "Add", disabled: false, action: {})
        .frame(width: 300, height: 45)
}

struct CustomButton: ButtonStyle {
    
    let disabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                backgroundForButton(isPressed: configuration.isPressed, disabled: disabled)
            )
        
    }
    
    @ViewBuilder func backgroundForButton(isPressed: Bool, disabled: Bool) -> some View {
        if isPressed {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blueButton1)
                    .northWestShadow(radius: 5, offset: 0)
                RoundedRectangle(cornerRadius: 12)
                    .inset(by: 1)
                    .fill(Color.darkShadow)
                    .southEastShadow(radius: 5, offset: 0)
            }
        } else {
            if disabled {
                Color.white.opacity(0.12)
            } else {
                Color.blueButton1
            }
        }
    }
}

extension View {
    func northWestShadow(radius: CGFloat = 3, offset: CGFloat = 6) -> some View {
        self
            .shadow(
                color: .white, radius: radius, x: -offset, y: -offset)
            .shadow(
                color: .black, radius: radius, x: offset, y: offset)
    }

    func southEastShadow(radius: CGFloat = 16, offset: CGFloat = 6) -> some View {
        self
            .shadow(
                color: .darkShadow, radius: radius, x: -offset, y: -offset)
            .shadow(
                color: .highlightShadow, radius: radius, x: offset, y: offset)
      }
}

