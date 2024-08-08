import SwiftUI

struct SettingsView: View {
    
    let dataManager: DataManager
    
    @State var showContacts = false
    @State var showTermsOfUse = false
    @State var showPrivacy = false
    @State var showLicense = false
    
    @State var showResetAlert = false
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            
            VStack(spacing: 28) {
                TextCustom(text: "Settings", size: 34, weight: .bold, color: .white)
                    .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack(spacing: 20) {
                    Button {
                        showContacts = true
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "bubble.fill")
                                .fontCustom(size: 20, weight: .semibold, color: .specialPrimary)
                            TextCustom(text: "Contact us", size: 16, weight: .bold, color: .almostWhite)
                        }
                        .padding(EdgeInsets(top: 18, leading: 16, bottom: 18, trailing: 16))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.settingsElementBackground)
                    .clipShape(.rect(cornerRadius: 10))
                    Button {
                        showPrivacy = true
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "shield.fill")
                                .fontCustom(size: 20, weight: .semibold, color: .specialPrimary)
                            TextCustom(text: "Privacy", size: 16, weight: .bold, color: .almostWhite)
                        }
                        .padding(EdgeInsets(top: 18, leading: 16, bottom: 18, trailing: 16))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.settingsElementBackground)
                    .clipShape(.rect(cornerRadius: 10))
                    Button {
                        showTermsOfUse = true
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "menucard.fill")
                                .fontCustom(size: 20, weight: .semibold, color: .specialPrimary)
                            TextCustom(text: "Terms of use", size: 16, weight: .bold, color: .almostWhite)
                        }
                        .padding(EdgeInsets(top: 18, leading: 16, bottom: 18, trailing: 16))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.settingsElementBackground)
                    .clipShape(.rect(cornerRadius: 10))
                    Button {
                        showLicense = true
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "wallet.pass.fill")
                                .fontCustom(size: 20, weight: .semibold, color: .specialPrimary)
                            TextCustom(text: "License", size: 16, weight: .bold, color: .almostWhite)
                        }
                        .padding(EdgeInsets(top: 18, leading: 16, bottom: 18, trailing: 16))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.settingsElementBackground)
                    .clipShape(.rect(cornerRadius: 10))
                }
                .padding(.horizontal, 15)
                
                Spacer()
                AddButton(title: "Reset data", disabled: false) {
                    showResetAlert = true
                }
                .padding(EdgeInsets(top: 0, leading: 52, bottom: 16, trailing: 52))
            }
            .frame(maxHeight: .infinity, alignment: .top)
            if showContacts {
                SettingsWebView(action: {
                    showTermsOfUse = false
                }, url: "https://www.termsfeed.com/live/7fefe868-1b6a-4aa0-aa24-f3f3cecf19bc")
            }
            if showTermsOfUse {
                SettingsWebView(action: {
                    showTermsOfUse = false
                }, url: "https://www.termsfeed.com/live/800912d3-eb11-4b2f-9caa-bff5ad5eecfa")
            }
            if showPrivacy {
                SettingsWebView(action: {
                    showPrivacy = false
                }, url: "https://www.termsfeed.com/live/7fefe868-1b6a-4aa0-aa24-f3f3cecf19bc")
            }
            if showLicense {
                SettingsWebView(action: {
                    showLicense = false
                }, url: "https://www.termsfeed.com/live/800912d3-eb11-4b2f-9caa-bff5ad5eecfa")
            }
            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(height: 0.4)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .alert(isPresented: $showResetAlert) {
            Alert(title: Text("Delete"), message: Text("Are you sure you want to delete?"),
                  primaryButton: .default(Text("Close"), action: {
                showResetAlert = false
            }), secondaryButton: .default(Text("Delete"), action: {
                dataManager.removeAll()
            }))
        }
    }
}

#Preview {
    SettingsView(dataManager: DataManager())
}
