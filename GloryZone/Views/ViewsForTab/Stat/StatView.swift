import SwiftUI

struct StatView: View {
    
    @ObservedObject var viewModel: StatViewModel
    
    var body: some View {
        Text("Stat")
    }
}

#Preview {
    StatView(viewModel: StatViewModel(dataManager: DataManager()))
}
