import Foundation

final class AddActivityViewModel: ObservableObject {
    
    let dataManager: DataManager
    
    @Published var text: String = ""
    @Published var date: Date = Date()
    @Published var time: Date = Date()
    
    init(dataManager: DataManager, date: Date) {
        self.dataManager = dataManager
        self.date = date
    }
    
    func addActivity() {
        let dateString = dateToString() + " " + timeToString()
        let activity = Activity(title: text, date: dateString)
        dataManager.addActivity(activity)
    }
    
    private func timeToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: time)
    }
    
    private func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
}
