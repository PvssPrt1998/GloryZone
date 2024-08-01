
import SwiftUI

struct EditTextField: View {
    
    @Binding var text: String
    
    let label: String
    let placeholder: String
    var trailingPadding: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 10) {
            TextField("", text: $text)
                .fontCustom(size: 15, weight: .regular, color: Color.almostWhite)
                .autocorrectionDisabled(true)
                .background(
                    placeholderView()
                )
        }
        .padding(EdgeInsets(top: 11, leading: 16, bottom: 11, trailing: 0))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0.35), lineWidth: 1)
        )
    }
    
    @ViewBuilder func placeholderView() -> some View {
        Text(text != "" ? "" : placeholder)
            .fontCustom(size: 15, weight: .regular, color: Color.placeholderSpecial)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct EditTextField_Preview: PreviewProvider {
    
    @State static var text = ""
    
    static var previews: some View {
        EditTextField(text: $text, label: "Name", placeholder: "Enter")
    }
}
