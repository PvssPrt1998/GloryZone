import SwiftUI

struct ParticipantRowView: View {
    
    @ObservedObject var viewModel: ParticipantRowViewModel
    
    let width: CGFloat
    let index: Int
    
    @Binding var isPortrait: Bool
    
    @State var showAlert = false
    
    @State var offset: CGFloat = 37
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        TextCustom(text: viewModel.getParticipantBy(index: index).name, size: 17, weight: .regular, color: .white)
                        TextCustom(text: viewModel.getParticipantBy(index: index).nickname, size: 15, weight: .regular, color: .specialSubtitle)
                    }
                    Rectangle()
                        .fill(Color.bgMain)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    TextCustom(text: gameTypeString(index: index), size: 17, weight: .regular, color: .specialSubtitle)
                }
                .padding(EdgeInsets(top: 9, leading: 16, bottom: 6, trailing: 16))
                .frame(width: width - horizontalPadding() * 2)
                if index != viewModel.participantsCount - 1 {
                    Rectangle()
                        .fill(Color.specialPrimary)
                        .frame(height: 3)
                }
            }
            .padding(.horizontal, horizontalPadding())
            .gesture(
                DragGesture()
                    .onEnded({ value in
                        if abs(value.translation.width) > 20 && (value.translation.width < 0) && !viewModel.isDeleteShown {
                            showDelete()
                        }
                        if abs(value.translation.width) > 20 && value.translation.width > 0 && viewModel.isDeleteShown {
                            hideDelete()
                        }
                    })
            )
            DeleteButton {
                showAlert = true
            }
        }
        .frame(width: width + 74)
        .offset(x: offset, y: 0)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Delete"), message: Text("Are you sure you want to delete?"),
                  primaryButton: .default(Text("Close"), action: {
                showAlert = false
                hideDelete()
            }), secondaryButton: .default(Text("Delete"), action: {
                deleteButtonAction()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    viewModel.deleteButtonAction(index)
                }
            }))
        }
    }
    
    private func deleteButtonAction() {
        withAnimation(.linear(duration: 0.1)) {
            offset = -width - 74
        }
    }
    
    private func showDelete() {
        withAnimation(.linear(duration: 0.1)) {
            offset = -74
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            viewModel.isDeleteShown = true
        }
    }
    
    private func hideDelete() {
        withAnimation(.linear(duration: 0.1)) {
            offset = 37
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            viewModel.isDeleteShown = false
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
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20
    }
}

final class ParticipantRowViewModel: ObservableObject {
    
    let dataManager: DataManager
    
    var width: CGFloat = 20
    
    var participantsCount: Int {
        dataManager.participants.count
    }
    
    var isDeleteShown = false
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func deleteButtonAction(_ index: Int) {
        dataManager.removeParticipant(index: index)
    }
    
    func getParticipantBy(index: Int) -> Participant {
        dataManager.participants[index]
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.current?.bounds.size.width
    static let screenHeight = UIScreen.current?.bounds.size.height
}
