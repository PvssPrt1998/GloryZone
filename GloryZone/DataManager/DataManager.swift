import Foundation

final class DataManager {
    
    var team: Team?
    var participants: Array<Participant> = []
    
    let localStorage = LocalStorage()
    
    @Published var dataLoaded: Bool = false
    private var localDataLoaded: Bool = false
    
    func setTeam(image: Data, title: String) {
        let team = Team(image: image, title: title)
        localStorage.save(team)
        self.team = team
    }
    
    func addParticipant(isDotaType: Bool, isLolType: Bool, name: String, nickname: String) {
        let participant = Participant(isDotaType: isDotaType, isLolType: isLolType, name: name, nickname: nickname)
        localStorage.save(participant)
        participants.append(participant)
    }
    
    func loadLocalData() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.localLoaded()
            }
        }
    }
    
    private func localLoaded() {
        localDataLoaded = true
        checkDataLoaded()
    }
    
    private func checkDataLoaded() {
        if localDataLoaded {
            dataLoaded = true
        }
    }
}
