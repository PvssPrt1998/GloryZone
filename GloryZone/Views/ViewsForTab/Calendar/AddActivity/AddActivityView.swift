import SwiftUI

struct AddActivityView: View {
    
    @ObservedObject var viewModel: AddActivityViewModel
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 0) {
                GrabberView()
                    .padding(5)
                TextCustom(text: "Add activities", size: 17, weight: .semibold, color: .white)
                    .padding(EdgeInsets(top: 11, leading: 0, bottom: 41, trailing: 0))
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
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 32 : 16
    }
    
    private func buttonDisabled() -> Bool {
        (viewModel.text != "") ? false : true
    }
}

struct AddActivity_Preview: PreviewProvider {
    static var previews: some View {
        AddActivityView(viewModel: AddActivityViewModel(dataManager: DataManager(), date: Date()),action: {})
            .background(Color.white)
    }
}
