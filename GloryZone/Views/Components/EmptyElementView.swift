import SwiftUI

struct EmptyElementView: View {
    
    let title: String
    let description: String
    let buttonTitle: String
    let showBackground: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 17) {
            VStack(spacing: 4) {
                TextCustom(text: title, size: 28, weight: .bold, color: Color.titleSpecial)
                TextCustom(text: description, size: 16, weight: .regular, color: Color.titleSpecial.opacity(0.7))
            }
            Button {
                action()
            } label: {
                TextCustom(text: buttonTitle, size: 15, weight: .regular, color: .white)
                    .padding(EdgeInsets(top: 7, leading: 14, bottom: 7, trailing: 14))
                    .frame(width: 210)
                    .background(Color.blueButton1)
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
        .padding(26)
        .background(bgColor())
        .clipShape(.rect(cornerRadius: 16))
    }
    
    private func bgColor() -> some View  {
        if showBackground {
            return Color.white.opacity(0.05)
        } else {
            return Color.clear
        }
    }
}

#Preview {
    EmptyElementView(title: "Add the data", description: "Indicate basic information", buttonTitle: "Add information", showBackground: true, action: {})
        .padding(50)
        .background(Color.bgMain)
}
