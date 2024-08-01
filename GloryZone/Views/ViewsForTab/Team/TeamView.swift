import SwiftUI

struct TeamView: View {
    
    @ObservedObject var viewModel: TeamViewModel
    
    init(viewModel: TeamViewModel) {
        self.viewModel = viewModel
        
        UIScrollView.appearance().bounces = true
    }
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            //TeamInfo
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
                } else {
                    GeometryReader { proxy in
                        ZStack {
                            ScrollView(.vertical, showsIndicators: false) {
                                LazyVStack(spacing: 0) {
                                    ForEach(0..<viewModel.participantsCount, id: \.self) { index in
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 0) {
                                                VStack(spacing: 0) {
                                                    HStack {
                                                        VStack(spacing: 4) {
                                                            TextCustom(text: viewModel.getParticipantBy(index: index).name, size: 17, weight: .regular, color: .white)
                                                            TextCustom(text: viewModel.getParticipantBy(index: index).nickname, size: 15, weight: .regular, color: .specialSubtitle)
                                                        }
                                                        Spacer()
                                                        TextCustom(text: gameTypeString(index: index), size: 17, weight: .regular, color: .specialSubtitle)
                                                    }
                                                    .padding(EdgeInsets(top: 9, leading: 16, bottom: 6, trailing: 16))
                                                    if index != viewModel.participantsCount - 1 {
                                                        Rectangle()
                                                            .fill(Color.specialPrimary)
                                                            .frame(height: 3)
                                                    }
                                                }
                                                .padding(.horizontal, horizontalPadding())
                                                .frame(width: proxy.size.width)
                                                DeleteButton {
                                                    print("lel")
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                                .padding(.bottom, 72)
                            }
                            AddButton(title: "Add a participants", disabled: false) {
                                viewModel.showAddParticipantSheet = true
                            }
                            .padding(.bottom, 16)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            //Participants
            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(height: 0.4)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .sheet(isPresented: $viewModel.showAddTeamSheet) {
            AddTeamView(viewModel: viewModel.makeAddTeamViewModel()) {
                viewModel.showAddTeamSheet = false
            }
        }
        .sheet(isPresented: $viewModel.showAddParticipantSheet) {
            AddParticipantView(viewModel: viewModel.makeAddParticipantViewModel()) {
                viewModel.showAddParticipantSheet = false
            }
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
        UIDevice.current.userInterfaceIdiom == .pad ? 87 : 20
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20
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

