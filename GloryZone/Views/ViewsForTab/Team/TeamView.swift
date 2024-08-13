import SwiftUI

struct TeamView: View {
    
    @ObservedObject var viewModel: TeamViewModel
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @State var screenWidth: CGFloat = 600
    @State var screenHeight: CGFloat = 300
    
    @State var isPortrait: Bool
    
    init(viewModel: TeamViewModel) {
        self.viewModel = viewModel
        self.isPortrait = UIDevice.current.orientation.isPortrait
        UIScrollView.appearance().bounces = true
    }
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            //TeamInfo
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 28) {
                    if viewModel.team != nil {
                        ZStack {
                            setImage()
                                .resizable()
                                .scaledToFit()
                            ZStack {
                                Color.specialPrimary
                                    .frame(height: 79)
                                TextCustom(text: viewModel.team!.title, size: 32, weight: .bold, color: .white)
                            }
                            .frame(maxHeight: .infinity, alignment: .bottom)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(logoHorizontalPadding())
                        .padding(EdgeInsets(top: 28,
                                            leading: logoHorizontalPadding(),
                                            bottom: 0,
                                        trailing: logoHorizontalPadding()))
                    } else {
                        EmptyElementView(title: "Add the info",
                                         description: "Indicate information about team",
                                         buttonTitle: "Add information",
                                         showBackground: true) {
                            viewModel.showAddTeamSheet = true
                        }
                        .padding(EdgeInsets(top: 36, leading: 0, bottom: 53, trailing: 0))
                    }
                    TextCustom(text: "Team", size: 32, weight: .bold, color: .white)
                        .padding(.horizontal, horizontalPadding())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if viewModel.participantsIsEmpty {
                        EmptyElementView(title: "Add participants",
                                         description: "Manage your team",
                                         buttonTitle: "Add a participants",
                                         showBackground: false) {
                            viewModel.showAddParticipantSheet = true
                        }
                        .padding(.top, -28)
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding(.bottom, UITabBarController().height)
                    } else {
                        LazyVStack(spacing: 0) {
                            ForEach(0..<viewModel.participantsCount, id: \.self) { index in
                                ParticipantRowView(viewModel: ParticipantRowViewModel(dataManager: viewModel.dataManager), width: widthRow(), index: index, isPortrait: $isPortrait)
                                    .ignoresSafeArea()
                            }
                        }
                    }
                }
                .padding(.bottom, UITabBarController().height + 58)
                .frame(maxHeight: .infinity, alignment: .top)
            }
            if !viewModel.participantsIsEmpty {
                AddButton(title: "Add a participants", disabled: false) {
                    viewModel.showAddParticipantSheet = true
                }
                .padding(EdgeInsets(top: 0, leading: 52, bottom: 16, trailing: 52))
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(height: 0.4)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .sheet(isPresented: $viewModel.showAddTeamSheet) {
            AddTeamView(viewModel: viewModel.makeAddTeamViewModel(), isPortrait: $isPortrait) {
                viewModel.showAddTeamSheet = false
            }
        }
        .sheet(isPresented: $viewModel.showAddParticipantSheet) {
            AddParticipantView(viewModel: viewModel.makeAddParticipantViewModel(), isPortrait: $isPortrait) {
                viewModel.showAddParticipantSheet = false
            }
        }
        .onAppear {
            setScreenSize()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                        guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
                        self.isPortrait = scene.interfaceOrientation.isPortrait
                    }
    }
    
    private func setScreenSize() {
        let screenHeight1 = UIScreen.screenHeight ?? 0
        let screenWidth1 = UIScreen.screenWidth ?? 0
        self.screenHeight = max(screenHeight1, screenWidth1)
        self.screenWidth = min(screenHeight1, screenWidth1)
    }
    
    private func widthRow() -> CGFloat {
        if isPortrait {
            return screenWidth
        } else {
            return screenHeight
        }
    }
    
    private func gameTypeString(index: Int) -> String {
        var str: String = ""
        if viewModel.getParticipantBy(index: index).isDotaType {
            str += "Dota2"
        }
        if viewModel.getParticipantBy(index: index).isLolType {
            if viewModel.getParticipantBy(index: index).isDotaType {
                str += "/"
            }
            str += "LoL"
        }
        return str
    }
    
    private func logoHorizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 87 + max(safeAreaInsets.trailing, safeAreaInsets.leading) : 20 + max(safeAreaInsets.trailing, safeAreaInsets.leading)
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 40 + max(safeAreaInsets.trailing, safeAreaInsets.leading) : 20 + max(safeAreaInsets.trailing, safeAreaInsets.leading)
    }
    
    private func setImage() -> Image {
        guard let imageData = viewModel.team?.image,
                let image = UIImage(data: imageData) else {
            return Image(systemName: "photo")
        }
        return Image(uiImage: image)
    }
}

#Preview {
    TeamView(viewModel: TeamViewModel(dataManager: DataManager()))
}

extension UITabBarController {
    var height: CGFloat {
        return self.tabBar.frame.size.height
    }
    
    var width: CGFloat {
        return self.tabBar.frame.size.width
    }
}
