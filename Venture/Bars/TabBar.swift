//
//  TabBar.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

struct TabBar: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .feed
    @State var color: Color = .white.opacity(0.6)
    @State var tabItemWidth: CGFloat = 0
    @EnvironmentObject var model: Model
    
    @Binding var showModal: Bool
    
    var body: some View {
        GeometryReader { proxy in
            
            //New logic for determining if has homeIndicator: If it has less safeAreaInset, then it has a homeIndicator.
            let hasHomeIndicator = proxy.safeAreaInsets.bottom <= 20
            
            HStack(spacing: 32){
                buttons
            }

            .padding(.vertical, 4)
            
            .frame(height: hasHomeIndicator ? 50 : 68, alignment: .top) //Used to be 72 vs 86
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 0, style: .continuous))
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            
        }
    }
    
    var buttons: some View {
        ForEach(tabItems) { item in
            Group {
                if item.tab == .post {
                    Button(action: {
                        showModal = true
                    }) {
                        VStack(spacing: 0) {
                            Image(systemName: item.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                                .frame(width: 44, height: 29)

                            Text(item.text)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                        .foregroundColor(.secondary)
                    }
                }
                else {
                    Button {
                        selectedTab = item.tab
                        color = item.color.opacity(0.6)
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: item.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                                .frame(width: 44, height: 29)
                            Text(item.text)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(selectedTab == item.tab ? .primary : .secondary)
                    .onPreferenceChange(TabPreferenceKey.self) { value in
                        tabItemWidth = value
                    }
                }
                
            }
        }
    }
    
    struct TabBar_Previews: PreviewProvider {
        static var previews: some View {
            TabBar(showModal: .constant(false))
                .environmentObject(Model())
                .previewInterfaceOrientation(.portrait)
        }
    }
}
