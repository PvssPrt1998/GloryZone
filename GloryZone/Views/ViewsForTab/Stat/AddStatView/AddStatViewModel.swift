import Foundation

final class AddStatViewModel: ObservableObject {
    
    let dataManager: DataManager
    let isDotaType: Bool
    
    @Published var winsText: String = ""
    @Published var lossesText: String = ""
    @Published var firstPlacesText: String = ""
    @Published var playersInTeamText: String = ""
    
    init(dataManager: DataManager, isDotaType: Bool) {
        self.dataManager = dataManager
        self.isDotaType = isDotaType
    }
    
    func setStat() {
        guard let wins = Int(winsText), let losses = Int(lossesText), let firstPlaces = Int(firstPlacesText), let playersInTeam = Int(playersInTeamText) else { return }
        if isDotaType {
            dataManager.setDotaStat(Stat(isDotaType: isDotaType, quantityOfWins: wins, quantityOfLosses: losses, numberOfFirstPlacesTaken: firstPlaces, numberOfPlayersInTeam: playersInTeam))
        } else {
            dataManager.setLolStat(Stat(isDotaType: isDotaType, quantityOfWins: wins, quantityOfLosses: losses, numberOfFirstPlacesTaken: firstPlaces, numberOfPlayersInTeam: playersInTeam))
        }
    }
}
