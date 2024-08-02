import SwiftUI

struct AddStatView: View {
    
    @ObservedObject var viewModel: AddStatViewModel
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 0) {
                GrabberView()
                    .padding(5)
                TextCustom(text: "Editing \(viewModel.isDotaType ? "Dota2" : "LoL") stats", size: 17, weight: .semibold, color: .white)
                    .padding(EdgeInsets(top: 11, leading: 0, bottom: 41, trailing: 0))
                VStack(spacing: 20) {
                    EditTextField(text: $viewModel.winsText, label: "Name team", placeholder: "Enter quantity of wins")
                        .onChange(of: viewModel.winsText, perform: { newValue in
                            winsValidation(newValue)
                        })
                        .keyboardType(.numberPad)
                    EditTextField(text: $viewModel.lossesText, label: "Name team", placeholder: "Enter quantity of losses")
                        .onChange(of: viewModel.lossesText, perform: { newValue in
                            lossesValidation(newValue)
                        })
                        .keyboardType(.numberPad)
                    EditTextField(text: $viewModel.firstPlacesText, label: "Name team", placeholder: "Enter number of first places taken")
                        .onChange(of: viewModel.firstPlacesText, perform: { newValue in
                            firstPlacesValidation(newValue)
                        })
                        .keyboardType(.numberPad)
                    EditTextField(text: $viewModel.playersInTeamText, label: "Name team", placeholder: "Enter number of players in team")
                        .onChange(of: viewModel.playersInTeamText, perform: { newValue in
                            playersInTeamValidation(newValue)
                        })
                        .keyboardType(.numberPad)
                    
                    AddButton(title: "Edit", disabled: buttonDisabled()) {
                        viewModel.setStat()
                        action()
                    }
                }
                .padding(.horizontal, horizontalPadding())
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private func winsValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }

        if filtered != "" {
            viewModel.winsText = filtered
        } else {
            viewModel.winsText = ""
        }
    }
    
    private func lossesValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }

        if filtered != "" {
            viewModel.lossesText = filtered
        } else {
            viewModel.lossesText = ""
        }
    }
    
    private func firstPlacesValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }

        if filtered != "" {
            viewModel.firstPlacesText = filtered
        } else {
            viewModel.firstPlacesText = ""
        }
    }
    
    private func playersInTeamValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }

        if filtered != "" {
            viewModel.playersInTeamText = filtered
        } else {
            viewModel.playersInTeamText = ""
        }
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 32 : 16
    }
    
    private func buttonDisabled() -> Bool {
        (viewModel.winsText != "" && viewModel.lossesText != "" && viewModel.firstPlacesText != "" && viewModel.playersInTeamText != "") ? false : true
    }
}

struct AddStat_Preview: PreviewProvider {
    static var previews: some View {
        AddStatView(viewModel: AddStatViewModel(dataManager: DataManager(), isDotaType: true),action: {})
            .background(Color.white)
    }
}
