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
        }
        .buttonStyle(DeleteButtonStyle())
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
            .clipShape(.rect(cornerRadius: 8))
            .padding(EdgeInsets(top: configuration.isPressed ? 6 : 0,
                                leading: configuration.isPressed ? 7 : 0,
                                bottom: configuration.isPressed ? 6 : 0,
                                trailing: configuration.isPressed ? 7 : 0))
            .frame(width: 74, height: 60)
            //.clipShape(.rect(cornerRadius: 8))
    }
}
