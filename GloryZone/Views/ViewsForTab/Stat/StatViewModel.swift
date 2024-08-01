import Foundation

final class  StatViewModel: ObservableObject {
    
    let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
}
