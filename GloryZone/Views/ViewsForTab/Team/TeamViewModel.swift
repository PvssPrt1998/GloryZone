import Foundation
import Combine

final class TeamViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    @Published var showAddTeamSheet: Bool = false
    @Published var showAddParticipantSheet: Bool = false
    
    var team: Team? {
        dataManager.team
    }
    
    var participantsIsEmpty: Bool {
        dataManager.participants.isEmpty
    }
    
    var participantsCount: Int {
        dataManager.participants.count
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func getParticipantBy(index: Int) -> Participant {
        dataManager.participants[index]
    }
    
    func makeAddTeamViewModel() -> AddTeamViewModel {
        AddTeamViewModel(dataManager: dataManager)
    }
    
    func makeAddParticipantViewModel() -> AddParticipantViewModel {
        AddParticipantViewModel(dataManager: dataManager)
    }
}
