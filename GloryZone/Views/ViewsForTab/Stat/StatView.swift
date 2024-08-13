import SwiftUI

struct StatView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @ObservedObject var viewModel: StatViewModel
    @State var isPortrait: Bool
    
    init(viewModel: StatViewModel) {
        self.viewModel = viewModel
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.specialPrimary)
        self.isPortrait = UIDevice.current.orientation.isPortrait
    }
    
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
        VStack(spacing: 28) {
            TextCustom(text: "Statistics", size: 34, weight: .bold, color: .white)
                .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
            Picker("", selection: $viewModel.gameType) {
                Text("Dota2").tag(0)
                Text("LoL").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, pickerHorizontalPadding())
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    VStack(spacing: 11) {
                        TextCustom(text: "\(viewModel.stat.quantityOfWins)", size: 34, weight: .bold, color: .specialPrimary)
                        TextCustom(text: "Quantity of wins", size: 13, weight: .regular, color: .white)
                    }
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
                    .frame(maxWidth: .infinity)
                    .background(Color.bgSecond)
                    .clipShape(.rect(cornerRadius: 10))
                    VStack(spacing: 11) {
                        TextCustom(text: "\(viewModel.stat.quantityOfLosses)", size: 34, weight: .bold, color: .specialPrimary)
                        TextCustom(text: "Quantity of losses", size: 13, weight: .regular, color: .white)
                    }
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
                    .frame(maxWidth: .infinity)
                    .background(Color.bgSecond)
                    .clipShape(.rect(cornerRadius: 10))
                }
                VStack(spacing: 11) {
                    TextCustom(text: "\(viewModel.stat.numberOfFirstPlacesTaken)", size: 34, weight: .bold, color: .specialPrimary)
                    TextCustom(text: "Quantity of first places taken", size: 13, weight: .regular, color: .white)
                }
                .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10)) //29
                .frame(maxWidth: .infinity)
                .background(Color.bgSecond)
                .clipShape(.rect(cornerRadius: 10))
                VStack(spacing: 11) {
                    TextCustom(text: "\(viewModel.stat.numberOfPlayersInTeam)", size: 34, weight: .bold, color: .specialPrimary)
                    TextCustom(text: "Quantity of players in team", size: 13, weight: .regular, color: .white)
                }
                .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
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
                .padding(.bottom, 8)
            }
            .padding(.horizontal, horizontalPadding())
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                        guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
                        self.isPortrait = scene.interfaceOrientation.isPortrait
                    }
    }
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            contentWrapper
            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(height: 0.4)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .sheet(isPresented: $viewModel.showDotaAddStatSheet) {
            AddStatView(viewModel: viewModel.makeAddStatViewModel(), isPortrait: $isPortrait) {
                viewModel.showDotaAddStatSheet = false
            }
        }
        .sheet(isPresented: $viewModel.showLoLAddStatSheet) {
            AddStatView(viewModel: viewModel.makeAddStatViewModel(), isPortrait: $isPortrait) {
                viewModel.showLoLAddStatSheet = false
            }
        }
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 41 + max(safeAreaInsets.trailing, safeAreaInsets.leading) : 15 + max(safeAreaInsets.trailing, safeAreaInsets.leading)
    }
    
    private func pickerHorizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 58 + max(safeAreaInsets.trailing, safeAreaInsets.leading) : 41 + max(safeAreaInsets.trailing, safeAreaInsets.leading)
    }
}

#Preview {
    StatView(viewModel: StatViewModel(dataManager: DataManager()))
}
