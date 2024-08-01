import SwiftUI

struct AddParticipantView: View {
    
    @ObservedObject var viewModel: AddParticipantViewModel
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 0) {
                GrabberView()
                    .padding(5)
                TextCustom(text: "Add participants", size: 17, weight: .semibold, color: .white)
                    .padding(EdgeInsets(top: 11, leading: 0, bottom: 41, trailing: 0))
                VStack(spacing: 20) {
                    EditTextField(text: $viewModel.nameText, label: "Name team", placeholder: "Enter name")
                    EditTextField(text: $viewModel.nicknameText, label: "Name team", placeholder: "Enter nickname")
                    
                    HStack(spacing: 16) {
                        TextCustom(text: "Main game", size: 17, weight: .regular, color: .almostWhite)
                        Spacer()
                        HStack(spacing: 4) {
                            TextCustom(text: "Dota2", size: 17, weight: .semibold)
                                .padding(.vertical, 8)
                                .frame(width: 100)
                                .background(viewModel.dotaSelected ? Color.blueButton1 : Color.clear)
                                .clipShape(.rect(cornerRadius: 8))
                                .padding(2)
                                .background(Color.bgSecond)
                                .clipShape(.rect(cornerRadius: 8))
                                .onTapGesture {
                                    viewModel.dotaSelected.toggle()
                                }
                            
                            TextCustom(text: "LoL", size: 17, weight: .semibold)
                                .padding(.vertical, 8)
                                .frame(width: 100)
                                .background(viewModel.lolSelected ? Color.blueButton1 : Color.clear)
                                .clipShape(.rect(cornerRadius: 8))
                                .padding(2)
                                .background(Color.bgSecond)
                                .clipShape(.rect(cornerRadius: 8))
                                .onTapGesture {
                                    viewModel.lolSelected.toggle()
                                }
                        }
                    }
                    
                    AddButton(title: "Add", disabled: buttonDisabled()) {
                        viewModel.addParticipant()
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
        (viewModel.nameText != "" && viewModel.nicknameText != "" && (viewModel.dotaSelected == true || viewModel.lolSelected == true)) ? false : true
    }
}

struct AddParticipant_Preview: PreviewProvider {
    static var previews: some View {
        AddParticipantView(viewModel: AddParticipantViewModel(dataManager: DataManager()),action: {})
            .background(Color.white)
    }
}
