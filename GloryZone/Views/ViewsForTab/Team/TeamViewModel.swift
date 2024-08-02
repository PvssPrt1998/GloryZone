import Foundation
import Combine

final class TeamViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    @Published var showAddTeamSheet: Bool = false
    @Published var showAddParticipantSheet: Bool = false
    
    private var participantsCancellable: AnyCancellable?
    
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
        
        participantsCancellable = dataManager.$participants.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
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
