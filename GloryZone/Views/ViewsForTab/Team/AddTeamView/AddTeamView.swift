import SwiftUI

struct AddTeamView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @ObservedObject var viewModel: AddTeamViewModel
    
    @Binding var isPortrait: Bool
    let action: () -> Void
    
    @ViewBuilder var contentWrapper: some View {
        if isPortrait {
            content
        } else {
            ScrollView {
                content
            }
        }
    }
    
    var content: some View {
        VStack(spacing: 0) {
            if isPortrait {
                GrabberView()
                    .padding(5)
            }
            
            ZStack {
                TextCustom(text: "Add the info", size: 17, weight: .semibold, color: .white)
                    .padding(EdgeInsets(top: 11, leading: 0, bottom: 41, trailing: 0))
                
                if !isPortrait {
                    Button {
                        action()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundColorCustom(.white)
                            .frame(width: 24, height: 24)
                    }
                    .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 24 + max(safeAreaInsets.trailing, safeAreaInsets.leading)))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                }
            }
            
            
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
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            contentWrapper
        }
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 32 + max(safeAreaInsets.trailing, safeAreaInsets.leading) : 16 + max(safeAreaInsets.trailing, safeAreaInsets.leading)
    }
    
    private func buttonDisabled() -> Bool {
        (viewModel.text != "" && viewModel.imageData != nil) ? false : true
    }
}

struct AddTeam_Preview: PreviewProvider {
    
    @State static var isPortrait = true
    
    static var previews: some View {
        AddTeamView(viewModel: AddTeamViewModel(dataManager: DataManager()), isPortrait: $isPortrait,action: {})
            .background(Color.white)
    }
}
