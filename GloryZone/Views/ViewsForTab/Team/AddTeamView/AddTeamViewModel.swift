import Foundation

final class AddTeamViewModel: ObservableObject {
    
    let dataManager: DataManager
    
    @Published var imageData: Data?
    @Published var text: String = ""
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func setTeam() {
        guard let imageData = imageData else { return }
        dataManager.setTeam(image: imageData, title: text)
    }
}
