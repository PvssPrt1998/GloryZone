import Foundation

final class AddParticipantViewModel: ObservableObject {
    
    let dataManager: DataManager

    @Published var nameText: String = ""
    @Published var nicknameText: String = ""
    @Published var dotaSelected: Bool = false
    @Published var lolSelected: Bool = false
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func addParticipant() {
        dataManager.addParticipant(isDotaType: dotaSelected, isLolType: lolSelected, name: nameText, nickname: nicknameText)
    }
}
