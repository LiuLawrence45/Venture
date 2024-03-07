//
//  NavigationBar.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

struct NavigationBar: View {
    var title = ""
    var context: String
    @Binding var hasScrolled: Bool
    @State var showSearch = false
    @State var showNotifications = false
    @State var showAccount = false
    @State var showEditProfile = false
    @AppStorage("showModal") var showModal = false
    @AppStorage("isLogged") var isLogged = false
    @Environment(\.presentationMode) var presentationMode
    
    var displayIcons = true
    var body: some View {
        ZStack {
            
            //Navigation Links for NavBar
            NavigationLink(destination: SearchUserView(), isActive: $showSearch) {
                EmptyView()
            }
            
            //Replace NotReadyView() with NotificationsView(hasScrolled: .constant(true)
            NavigationLink(destination: NotReadyView(), isActive: $showNotifications){
                EmptyView()
            }
            
            NavigationLink(destination: AccountView(), isActive: $showAccount) {
                EmptyView()
            }
            
            NavigationLink(destination: EditProfileView(), isActive: $showEditProfile) {
                EmptyView()
            }

            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(hasScrolled ? 1 : 0)
            
            Text(title)
                .font(.custom("Michroma-Regular", size: hasScrolled ? 22: 34))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 20)
                .offset(y: hasScrolled ? -4 : 0)
                .shadow(color: .white.opacity(0.6), radius: 10, x: 0, y: 0)
                .shadow(color: .white.opacity(0.6), radius: 20, x: 0, y: 0)
                .shadow(color: .white.opacity(0.5), radius: 30, x: 0, y: 0)
            
            HStack(spacing: 16) {
                if context == "default" {
                    Button {
                        showSearch = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title3.weight(.bold))
                            .animatableFont(size: hasScrolled ? 18 : 20, weight: .bold)
                            .frame(width: 48, height: 48)
                            .foregroundColor(.primary)
                    }
                    Button {
                        showNotifications = true
                    } label: {
                        Image(systemName: "bell")
                            .font(.title3.weight(.bold))
                            .animatableFont(size: hasScrolled ? 18 : 20, weight: .bold)
                            .frame(width: 48, height: 48)
                            .foregroundColor(.primary)
                    }
                    
                }
                
                else if context == "profile" {
                    Button {
                        showAccount = true
                    } label: {
                        Image(systemName: "gear")
                            .font(.title3.weight(.bold))
                            .animatableFont(size: hasScrolled ? 18 : 20, weight: .bold)
                            .frame(width: 48, height: 48)
                            .foregroundColor(.primary)
                    }
                    
                    Button {
                        showEditProfile = true
                    } label: {
                        Image(systemName: "pencil")
                            .font(.title3.weight(.bold))
                            .animatableFont(size: hasScrolled ? 18 : 20, weight: .bold)
                            .frame(width: 48, height: 48)
                            .foregroundColor(.primary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
//            .padding(.trailing, 20)
            .padding(.top, 20)
            .offset(y: hasScrolled ? -4 : 0)
            .opacity(displayIcons ? 100 : 0)
        }
        .frame(height: hasScrolled ? 44 : 70)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "Featured", context: "profile",
                      hasScrolled: .constant(false)
        )
    }
}
