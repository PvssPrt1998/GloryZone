import SwiftUI

struct CalendarView: View {
    
    @ObservedObject var viewModel: CalendarViewModel
    
    var body: some View {
        Text("Calendar")
    }
}

#Preview {
    CalendarView(viewModel: CalendarViewModel(dataManager: DataManager()))
}
