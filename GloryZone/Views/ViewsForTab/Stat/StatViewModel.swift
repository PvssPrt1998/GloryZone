import Foundation
import Combine

final class  StatViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    @Published var showDotaAddStatSheet = false
    @Published var showLoLAddStatSheet = false
    @Published var gameType = 0
    
    private var dotaCancellable: AnyCancellable?
    private var lolCancellable: AnyCancellable?
    
    
    var stat: Stat {
        if gameType == 0 {
            return dataManager.dotaStat
        } else {
            return dataManager.lolStat
        }
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        
        dotaCancellable = dataManager.$dotaStat.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        lolCancellable = dataManager.$lolStat.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func makeAddStatViewModel() -> AddStatViewModel {
       AddStatViewModel(dataManager: dataManager, isDotaType: gameType == 0 ? true : false)
    }
}
