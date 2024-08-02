import Foundation

final class DataManager {
    
    var team: Team?
    @Published var participants: Array<Participant> = []
    @Published var activities: Array<Activity> = []
    @Published var dotaStat: Stat = Stat(quantityOfWins: 0, quantityOfLosses: 0, numberOfFirstPlacesTaken: 0, numberOfPlayersInTeam: 0)
    @Published var lolStat: Stat = Stat(quantityOfWins: 0, quantityOfLosses: 0, numberOfFirstPlacesTaken: 0, numberOfPlayersInTeam: 0)
    
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
    
    func addActivity(_ activity: Activity) {
        localStorage.save(activity)
        activities.append(activity)
    }
    
    func loadLocalData() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.localLoaded()
            }
        }
    }
    
    func setDotaStat(_ stat: Stat) {
        self.dotaStat = stat
    }
    
    func setLolStat(_ stat: Stat) {
        self.lolStat = stat
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
