//
//  SettingsView.swift
//  GloryZone
//
//  Created by Николай Щербаков on 01.08.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            
            VStack(spacing: 28) {
                TextCustom(text: "Settings", size: 34, weight: .bold, color: .white)
                    .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack(spacing: 20) {
                    Button {
                        //action contact
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
                        //action contact
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
                        //action contact
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
                        //action contact
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
                    
                }
                .padding(EdgeInsets(top: 0, leading: 52, bottom: 16, trailing: 52))
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    SettingsView()
}
