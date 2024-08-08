import SwiftUI

struct CalendarView: View {
    
    @ObservedObject var viewModel: CalendarViewModel
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
                VStack(spacing: 15) {
                    VStack(spacing: 25) {
                        TextCustom(text: "Calendar", size: 34, weight: .bold, color: .white)
                            .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        DatePicker("", selection: $viewModel.date, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .id(viewModel.date)
                            .background(Color.calendarBackground)
                            .clipShape(.rect(cornerRadius: 13))
                            .padding(.horizontal, 15)
                    }
                    HStack {
                        TextCustom(text: "Activities", size: 20, weight: .semibold)
                        Spacer()
                        Button {
                            viewModel.showAddActivitySheet = true
                        } label: {
                            Image(systemName: "plus")
                                .fontCustom(size: 22, weight: .medium, color: .specialPrimary)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding(.horizontal, 15)
                    if viewModel.activities.isEmpty {
                        TextCustom(text: "There are no scheduled\nholidays for this day", size: 16, weight: .regular, color: .emptyActivities)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 38)
                            .frame(maxHeight: .infinity, alignment: .center)
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack(spacing: 15) {
                                ForEach(viewModel.activities, id: \.self) { activity in
                                    VStack(spacing: 10) {
                                        TextCustom(text: activity.title, size: 17, weight: .semibold, color: .white)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        VStack(alignment: .leading, spacing: 0) {
                                            TextCustom(text: dateWithoutTime(date: activity.date), size: 12, weight: .regular, color: .white.opacity(0.35))
                                            TextCustom(text: dateTime(date: activity.date), size: 12, weight: .regular, color: .white.opacity(0.35))
                                        }.frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .padding(EdgeInsets(top: 15, leading: 24, bottom: 15, trailing: 24))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.bgSecond)
                                    .clipShape(.rect(cornerRadius: 12))
                                }
                            }
                            .padding(.horizontal, 15)
                        }
                        .clipShape(.rect(cornerRadius: 12))
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(height: 0.4)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .sheet(isPresented: $viewModel.showAddActivitySheet) {
            AddActivityView(viewModel: viewModel.makeAddActivityViewModel()) {
                viewModel.showAddActivitySheet = false
            }
        }
    }
    
    private func dateTime(date: String) -> String {
        "Beginning " + date.components(separatedBy: " ")[1]
    }
    
    private func dateWithoutTime(date: String) -> String {
        guard let dateStr = date.components(separatedBy: " ").first else { return "Cannot get date" }
        let dateComponents = dateStr.components(separatedBy: "/")
        let year = dateComponents[0]
        let month = dateComponents[1]
        let day = dateComponents[2]
        
        var monthTitle = ""
        switch month {
        case "01": monthTitle = "January"
        case "02": monthTitle = "February"
        case "03": monthTitle = "March"
        case "04": monthTitle = "April"
        case "05": monthTitle = "May"
        case "06": monthTitle = "June"
        case "07": monthTitle = "July"
        case "08": monthTitle = "August"
        case "09": monthTitle = "September"
        case "10": monthTitle = "October"
        case "11": monthTitle = "November"
        case "12": monthTitle = "December"
        default: break
        }
        
        return day + monthTitle + year
    }
}

#Preview {
    CalendarView(viewModel: CalendarViewModel(dataManager: DataManager()))
}
