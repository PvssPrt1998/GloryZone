import SwiftUI

struct DeleteButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "trash.fill")
                .fontCustom(size: 17, weight: .regular, color: .white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                //.background(Color.deleteButton)
        }
        .buttonStyle(DeleteButtonStyle())
        //.clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    DeleteButton(action: {})
}

struct DeleteButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                configuration.isPressed ? Color.deleteButton.opacity(0.8) : Color.deleteButton
            )
            .frame(width: configuration.isPressed ? 60 : 74, height: configuration.isPressed ? 48 : 60)
            .clipShape(.rect(cornerRadius: 8))
    }
}
