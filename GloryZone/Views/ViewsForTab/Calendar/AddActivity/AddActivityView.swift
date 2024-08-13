import SwiftUI

struct AddActivityView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @ObservedObject var viewModel: AddActivityViewModel
    
    @Binding var isPortrait: Bool
    
    let action: () -> Void
    
    @ViewBuilder var contentWrapper: some View {
        if isPortrait {
            content
        } else {
            ScrollView {
                content
            }
        }
    }
    
    var content: some View {
        VStack(spacing: 0) {
            if isPortrait {
                GrabberView()
                    .padding(5)
            }
            
            ZStack {
                TextCustom(text: "Add activities", size: 17, weight: .semibold, color: .white)
                    .padding(EdgeInsets(top: 11, leading: 0, bottom: 41, trailing: 0))
                if !isPortrait {
                    Button {
                        action()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundColorCustom(.white)
                            .frame(width: 24, height: 24)
                    }
                    .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 24 + max(safeAreaInsets.trailing, safeAreaInsets.leading)))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                }
            }
            
            VStack(spacing: 20) {
                EditTextField(text: $viewModel.text, label: "Name team", placeholder: "Enter name")
                HStack(spacing: 15) {
                    TextCustom(text: "Date", size: 15, weight: .regular, color: .white)
                    DatePicker("", selection: $viewModel.date, displayedComponents: .date)
                        .labelsHidden()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 15) {
                    TextCustom(text: "Beginning", size: 15, weight: .regular, color: .white)
                    DatePicker("", selection: $viewModel.time, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                AddButton(title: "Add", disabled: buttonDisabled()) {
                    viewModel.addActivity()
                    action()
                }
            }
            .padding(.horizontal, horizontalPadding())
            .padding(.bottom, 8)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            contentWrapper
        }
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 32 + max(safeAreaInsets.trailing, safeAreaInsets.leading) : 16 + max(safeAreaInsets.trailing, safeAreaInsets.leading)
    }
    
    private func buttonDisabled() -> Bool {
        (viewModel.text != "") ? false : true
    }
}

struct AddActivity_Preview: PreviewProvider {
    
    @State static var isPortrait = true
    
    static var previews: some View {
        AddActivityView(viewModel: AddActivityViewModel(dataManager: DataManager(), date: Date()), isPortrait: $isPortrait,action: {})
            .background(Color.white)
    }
}
