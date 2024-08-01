import SwiftUI

@main
struct ProScoreApp: App {
    
    @ObservedObject var coordinator: Coordinator
    
    init() {
        self.coordinator = Coordinator(viewModelFactory:
                                                ViewModelFactory(dataManager:
                                                                    DataManager()))
    }
    
    var body: some Scene {
        WindowGroup {
            coordinator.build()
                .preferredColorScheme(.dark)
        }
    }
}
