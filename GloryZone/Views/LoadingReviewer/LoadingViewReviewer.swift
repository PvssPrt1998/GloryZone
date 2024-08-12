import SwiftUI

struct LoadingViewReviewer: View {
    
    @ObservedObject var viewModel: LoadingViewModel
    
    var body: some View {
        ZStack {
            Color.loadingBackground1
            Image(ImageTitles.LoadingReviewerBackground.rawValue)
                .resizable()
            ProgressViewCustom(value: $viewModel.value)
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.stroke()
        }
    }
}

#Preview {
    LoadingViewReviewer(viewModel: LoadingViewModel(dataManager: DataManager()))
}
