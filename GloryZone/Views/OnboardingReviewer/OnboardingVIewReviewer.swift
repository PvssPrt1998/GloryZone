import SwiftUI
import Combine

struct OnboardingViewReviewer: View {
    
    let toNext = PassthroughSubject<Bool, Never>()
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @State private var selection = 0
    @State private var offset: CGFloat = 0
    
    private var backgroundsTitles = [
        ImageTitles.OnboardingBackgroundReviewer1.rawValue,
        ImageTitles.OnboardingBackgroundReviewer2.rawValue,
        ImageTitles.OnboardingBackgroundReviewer3.rawValue
    ]
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ZStack {
            ScrollView(.init()) {
                TabView(selection: $selection) {
                    ForEach(backgroundsTitles.indices, id: \.self) { index in
                        if index == 1 {
                            Image(backgroundsTitles[index])
                                .resizable()
                                .overlay(
                                    GeometryReader { proxy -> Color in
                                        let minX = proxy.frame(in: .global).minX
                                        DispatchQueue.main.async {
                                            withAnimation(.default) {
                                                self.offset = -minX
                                            }
                                        }
                                        
                                        return Color.clear
                                    }
                                    .frame(width: 0, height: 0)
                                    ,alignment: .leading
                                )
                        } else {
                            Image(backgroundsTitles[index])
                                .resizable()
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .overlay(
                    ZStack {
                        VStack {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            VStack(alignment: .leading, spacing: 10) {
                                TextCustom(text: textFor(selection: selection).0,
                                           size: 28,
                                           weight: .bold)
                                TextCustom(text: textFor(selection: selection).1,
                                           size: 17,
                                           weight: .regular,
                                           color: .white.opacity(0.4))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                        .padding(.horizontal, horizontalPadding())
                        
                        HStack {
                            indicatorView()
                            Spacer()
                            NextButton(action: nextButtonPressed)
                        }
                        .padding(EdgeInsets(top: 0, leading: horizontalPadding(),
                                            bottom: safeAreaInsets.bottom + 55,
                                            trailing: horizontalPadding()))
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                )
            }
            .ignoresSafeArea()
        }
    }
    
    private func nextButtonPressed() {
        if selection < 2 {
            increaseSelection()
        } else {
            toNext.send(true)
        }
    }
    
    private func increaseSelection() {
        withAnimation {
            selection += 1
        }
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 30 : 15
    }
    
    private func indicatorView() -> some View {
        HStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.white.opacity(opacityBy(index: 0)))
                .frame(width: indicatorWidthBy(index: 0), height: 8)
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.white.opacity(opacityBy(index: 1)))
                .frame(width: indicatorWidthBy(index: 1), height: 8)
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.white.opacity(opacityBy(index: 2)))
                .frame(width: indicatorWidthBy(index: 2), height: 8)
        }
        .frame(height: 8)
    }
    
    private func indicatorWidthBy(index: Int) -> CGFloat {
        selection == index ? 25 : 8
    }
    
    private func opacityBy(index: Int) -> CGFloat {
        selection == index ? 1 : 0.3
    }
    
    private func textFor(selection: Int) -> (String, String) {
        switch selection {
        case 0: return ("Your team","Enter the stats for your team\n  ")
        case 1: return ("Game statistics", "All important points for tracking\nstatistics")
        case 2: return ("Modify and nurture", "Quick data change right in your\npocket")
        default: return ("Invalid onoarding index", "Invalid onboarding index\n  ")
        }
    }
    
    private func getIndex() -> Int {
        Int(round(Double(offset / getWidth())))
    }
}

#Preview {
    OnboardingViewReviewer()
}

extension View {
    func getWidth() -> CGFloat {
        UIScreen.current?.bounds.width ?? 0
    }
}

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}


extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
