import Foundation

final class CalendarViewModel: ObservableObject {
    
    @Published var date: Date = Date()
    
    @Published var showAddActivitySheet: Bool = false
    
    var activities: [Activity] {
        dataManager.activities
    }
    
    let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func makeAddActivityViewModel() -> AddActivityViewModel {
        AddActivityViewModel(dataManager: dataManager)
    }
}
