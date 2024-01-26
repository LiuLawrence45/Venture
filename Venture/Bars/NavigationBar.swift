//
//  NavigationBar.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

struct NavigationBar: View {
    var title = ""
    @Binding var hasScrolled: Bool
    @State var showSearch = false
    @State var showNotifications = false
    @State var showAccount = false
    @AppStorage("showModal") var showModal = false
    @AppStorage("isLogged") var isLogged = false
    @Environment(\.presentationMode) var presentationMode
    
    var displayIcons = true
    var body: some View {
        ZStack {
            
            NavigationLink(destination: SearchView(), isActive: $showSearch) {
                EmptyView()
            }
            
            NavigationLink(destination: NotificationsView(hasScrolled: .constant(true)), isActive: $showNotifications) {
                EmptyView()
            }

            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(hasScrolled ? 1 : 0)
            
            Text(title)
                .animatableFont(size: hasScrolled ? 22 : 34, weight: .bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 20)
                .offset(y: hasScrolled ? -4 : 0)
            
            HStack(spacing: 16) {
                Button {
                    showSearch = true
                } label: {
                    Image(systemName: "magnifyingglass")
                        //.font(.title3.weight(.bold))
                        .animatableFont(size: hasScrolled ? 18 : 20, weight: .bold)
                        .frame(width: 48, height: 48)
                        .foregroundColor(.primary)
                }

//                .sheet(isPresented: $showSearch) {
//                    SearchView()
//                }

                Button {
                    showNotifications = true
                } label: {
                    Image(systemName: "bell")
                        //.font(.title3.weight(.bold))
                        .animatableFont(size: hasScrolled ? 18 : 20, weight: .bold)
                        .frame(width: 48, height: 48)
                        .foregroundColor(.primary)
                }
//                .sheet(isPresented: $showNotifications) {
//                    NotificationsView(hasScrolled: .constant(false))
//                       
//                }
                

            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
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
        NavigationBar(title: "Featured", 
                      hasScrolled: .constant(false)
        )
    }
}
