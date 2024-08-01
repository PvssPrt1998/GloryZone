import Foundation

final class ViewModelFactory {
    
    let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func makeMainTabViewModel() -> MainTabViewModel {
        MainTabViewModel(dataManager: dataManager)
    }
    
    func makeLoadingViewModel() -> LoadingViewModel {
        LoadingViewModel(dataManager: dataManager)
    }
}
