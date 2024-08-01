import Foundation

final class MainTabViewModel{
    
    let dataManager: DataManager
    
    var teamViewModel: TeamViewModel
    var statViewModel: StatViewModel
    var calendarViewMode: CalendarViewModel
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        
        self.teamViewModel = TeamViewModel(dataManager: dataManager)
        self.statViewModel = StatViewModel(dataManager: dataManager)
        self.calendarViewMode = CalendarViewModel(dataManager: dataManager)
    }
}
