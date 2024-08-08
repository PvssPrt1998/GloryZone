
import SwiftUI

struct MainTabView: View {
    
    var viewModel: MainTabViewModel
    
    init(viewModel: MainTabViewModel) {
        
        self.viewModel = viewModel
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(rgbColorCodeRed: 99, green: 99, blue: 101, alpha: 1)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgbColorCodeRed: 99, green: 99, blue: 101, alpha: 1)]

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(rgbColorCodeRed: 250, green: 250, blue: 250, alpha: 1)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgbColorCodeRed: 250, green: 250, blue: 250, alpha: 1)]
        
        appearance.shadowColor = .white.withAlphaComponent(0.15)
        appearance.shadowImage = UIImage(named: "tab-shadow")?.withRenderingMode(.alwaysTemplate)
        UITabBar.appearance().standardAppearance = appearance
    }
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            TeamView(viewModel: viewModel.teamViewModel)
                .tabItem {
                    ItemMainView(imageTitle: "person.2.fill", text: "Team")
                }
                .tag(1)
            CalendarView(viewModel: viewModel.calendarViewMode)
                .tabItem {
                    ItemMainView(imageTitle: "calendar", text: "Calendar")
                }
                .tag(2)
            StatView(viewModel: viewModel.statViewModel)
                .tabItem {
                    ItemMainView(imageTitle: "chart.line.uptrend.xyaxis", text: "Statistics")
                }
                .tag(3)
            SettingsView(dataManager: viewModel.dataManager)
                .tabItem {
                    ItemMainView(imageTitle: "gearshape.fill", text: "Settings")
                }
                .tag(4)
        }
    }
}

#Preview {
    MainTabView(viewModel: MainTabViewModel(dataManager: DataManager()))
        .background(Color.black)
}

extension UIColor {
   convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {

     let redPart: CGFloat = CGFloat(red) / 255
     let greenPart: CGFloat = CGFloat(green) / 255
     let bluePart: CGFloat = CGFloat(blue) / 255

     self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
   }
}
