import Foundation

final class CalendarViewModel: ObservableObject {
    
    let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}
