import SwiftUI

struct NextButton: View {

    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            TextCustom(text: "Next", size: 14, weight: .bold, color: .almostWhite)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(NextButtonStyle())
        .frame(width: 160, height: 45)
    }
}

#Preview {
    NextButton(action: {})
        .frame(width: 200, height: 45)
}

struct NextButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                configuration.isPressed ? Color.nextButtonPressed : Color.specialPrimary
            )
            .clipShape(.rect(cornerRadius: 18))
    }
}
