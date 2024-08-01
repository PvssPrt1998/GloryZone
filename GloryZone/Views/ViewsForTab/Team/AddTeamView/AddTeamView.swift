import SwiftUI

struct AddTeamView: View {
    
    @ObservedObject var viewModel: AddTeamViewModel
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 0) {
                GrabberView()
                    .padding(5)
                TextCustom(text: "Add the info", size: 17, weight: .semibold, color: .white)
                    .padding(EdgeInsets(top: 11, leading: 0, bottom: 41, trailing: 0))
                VStack(spacing: 20) {
                    ImageView(imageData: $viewModel.imageData)
                        .frame(width: 160, height: 140)
                    EditTextField(text: $viewModel.text, label: "Name team", placeholder: "Enter")
                    AddButton(title: "Save", disabled: buttonDisabled()) {
                        viewModel.setTeam()
                        action()
                    }
                }
                .padding(.horizontal, horizontalPadding())
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 32 : 16
    }
    
    private func buttonDisabled() -> Bool {
        (viewModel.text != "" && viewModel.imageData != nil) ? false : true
    }
}

struct AddTeam_Preview: PreviewProvider {
    static var previews: some View {
        AddTeamView(viewModel: AddTeamViewModel(dataManager: DataManager()),action: {})
            .background(Color.white)
    }
}
