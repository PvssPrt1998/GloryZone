import Foundation

final class DataManager {
    
    var team: Team?
    @Published var participants: Array<Participant> = []
    @Published var activities: Array<Activity> = []
    @Published var dotaStat: Stat = Stat(isDotaType: true, quantityOfWins: 0, quantityOfLosses: 0, numberOfFirstPlacesTaken: 0, numberOfPlayersInTeam: 0)
    @Published var lolStat: Stat = Stat(isDotaType: false, quantityOfWins: 0, quantityOfLosses: 0, numberOfFirstPlacesTaken: 0, numberOfPlayersInTeam: 0)
    
    let localStorage = LocalStorage()
    
    @Published var dataLoaded: Bool = false
    private var localDataLoaded: Bool = false
    
    func setTeam(image: Data, title: String) {
        let team = Team(image: image, title: title)
        self.team = team
        localStorage.save(team)
    }
    
    func addParticipant(isDotaType: Bool, isLolType: Bool, name: String, nickname: String) {
        let participant = Participant(isDotaType: isDotaType, isLolType: isLolType, name: name, nickname: nickname)
        participants.append(participant)
        localStorage.save(participant)
    }
    
    func removeParticipant(index: Int) {
        try? localStorage.remove(participants[index])
        participants.remove(at: index)
    }
    
    func removeAll() {
        team = nil
        participants = []
        activities = []
        dotaStat = Stat(isDotaType: true, quantityOfWins: 0, quantityOfLosses: 0, numberOfFirstPlacesTaken: 0, numberOfPlayersInTeam: 0)
        lolStat = Stat(isDotaType: false, quantityOfWins: 0, quantityOfLosses: 0, numberOfFirstPlacesTaken: 0, numberOfPlayersInTeam: 0)
        try? localStorage.removeAll()
    }
    
    func addActivity(_ activity: Activity) {
        activities.append(activity)
        localStorage.save(activity)
    }
    
    func loadLocalData() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            
            team = try? localStorage.fetchTeam()
            
            if let participants = try? localStorage.fetchParticipants() {
                self.participants = participants
            }
            
            if let activities = try? localStorage.fetchActivities() {
                self.activities = activities
            }
            
            if let stats = try? localStorage.fetchStat() {
                self.dotaStat = stats.0
                self.lolStat = stats.1
            }
            
            DispatchQueue.main.async {
                self.localLoaded()
            }
        }
    }
    
    func setDotaStat(_ stat: Stat) {
        self.dotaStat = stat
        localStorage.save(stat)
    }
    
    func setLolStat(_ stat: Stat) {
        self.lolStat = stat
        localStorage.save(stat)
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
