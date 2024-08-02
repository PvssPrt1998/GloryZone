import SwiftUI

struct StatView: View {
    
    @ObservedObject var viewModel: StatViewModel
    
    init(viewModel: StatViewModel) {
        self.viewModel = viewModel
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.specialPrimary)
    }
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 28) {
                TextCustom(text: "Statistics", size: 34, weight: .bold, color: .white)
                    .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker("", selection: $viewModel.gameType) {
                    Text("Dota2").tag(0)
                    Text("LoL").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 41)
                VStack(spacing: 15) {
                    HStack(spacing: 15) {
                        VStack(spacing: 11) {
                            TextCustom(text: "\(viewModel.stat.quantityOfWins)", size: 34, weight: .bold, color: .specialPrimary)
                            TextCustom(text: "Quantity of wins", size: 13, weight: .regular, color: .white)
                        }
                        .padding(EdgeInsets(top: 29, leading: 10, bottom: 29, trailing: 10))
                        .frame(maxWidth: .infinity)
                        .background(Color.bgSecond)
                        .clipShape(.rect(cornerRadius: 10))
                        VStack(spacing: 11) {
                            TextCustom(text: "\(viewModel.stat.quantityOfLosses)", size: 34, weight: .bold, color: .specialPrimary)
                            TextCustom(text: "Quantity of losses", size: 13, weight: .regular, color: .white)
                        }
                        .padding(EdgeInsets(top: 29, leading: 10, bottom: 29, trailing: 10))
                        .frame(maxWidth: .infinity)
                        .background(Color.bgSecond)
                        .clipShape(.rect(cornerRadius: 10))
                    }
                    VStack(spacing: 11) {
                        TextCustom(text: "\(viewModel.stat.numberOfFirstPlacesTaken)", size: 34, weight: .bold, color: .specialPrimary)
                        TextCustom(text: "Quantity of first places taken", size: 13, weight: .regular, color: .white)
                    }
                    .padding(EdgeInsets(top: 29, leading: 10, bottom: 29, trailing: 10))
                    .frame(maxWidth: .infinity)
                    .background(Color.bgSecond)
                    .clipShape(.rect(cornerRadius: 10))
                    VStack(spacing: 11) {
                        TextCustom(text: "\(viewModel.stat.numberOfPlayersInTeam)", size: 34, weight: .bold, color: .specialPrimary)
                        TextCustom(text: "Quantity of players in team", size: 13, weight: .regular, color: .white)
                    }
                    .padding(EdgeInsets(top: 29, leading: 10, bottom: 29, trailing: 10))
                    .frame(maxWidth: .infinity)
                    .background(Color.bgSecond)
                    .clipShape(.rect(cornerRadius: 10))
                    AddButton(title: "Edit", disabled: false) {
                        if viewModel.gameType == 0 {
                            viewModel.showDotaAddStatSheet = true
                        } else {
                            viewModel.showLoLAddStatSheet = true
                        }
                    }
                }
                .padding(.horizontal, 15)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .sheet(isPresented: $viewModel.showDotaAddStatSheet) {
            AddStatView(viewModel: viewModel.makeAddStatViewModel()) {
                viewModel.showDotaAddStatSheet = false
            }
        }
        .sheet(isPresented: $viewModel.showLoLAddStatSheet) {
            AddStatView(viewModel: viewModel.makeAddStatViewModel()) {
                viewModel.showLoLAddStatSheet = false
            }
        }
    }
}

#Preview {
    StatView(viewModel: StatViewModel(dataManager: DataManager()))
}
