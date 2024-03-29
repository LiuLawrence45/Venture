//
//  TabBar.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

struct OldTabBar: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .feed
    @State var color: Color = .white.opacity(0.6)
    @State var tabItemWidth: CGFloat = 0
    @EnvironmentObject var model: Model
    
    var body: some View {
        GeometryReader { proxy in
            let hasHomeIndicator = proxy.safeAreaInsets.bottom - 88 > 20
            
            HStack {
                buttons
            }
            .padding(.horizontal, 8)
            .padding(.top, 14)
            .frame(height: hasHomeIndicator ? 72 : 86, alignment: .top) //Used to be 72 vs 86
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: hasHomeIndicator ? 0 : 0, style: .continuous))
//            .strokeStyle(cornerRadius: hasHomeIndicator ? 34 : 0)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
//            .offset(y: model.showTab ? 0 : 0)
//            .accessibility(hidden: !model.showTab)

        }
    }
    
    var buttons: some View {
        ForEach(tabItems) { item in
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selectedTab = item.tab
                    color = item.color.opacity(0.6)
                }
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
            .blendMode(selectedTab == item.tab ? .normal : .normal)
            .overlay(
                GeometryReader { proxy in
                    Color.clear.preference(key: TabPreferenceKey.self, value: proxy.size.width)
                }
            )
            .onPreferenceChange(TabPreferenceKey.self) { value in
                tabItemWidth = value
            }
        }
    }
    
    var background: some View {
        HStack {
            if selectedTab == .profile { Spacer() }
            if selectedTab == .post { }
            Circle().fill(color).frame(width: tabItemWidth)
            if selectedTab == .feed { Spacer() }
        }
        .padding(.horizontal, 8)
    }
    
    var overlay: some View {
        HStack {
            if selectedTab == .profile { Spacer() }
            if selectedTab == .post { }
            Rectangle()
                .fill(color)
                .frame(width: 28, height: 5)
                .cornerRadius(3)
                .frame(width: tabItemWidth)
                .frame(maxHeight: .infinity, alignment: .top)
            if selectedTab == .feed { Spacer() }
        }
        .padding(.horizontal, 8)
    }
    
}

struct OldTabBar_Previews: PreviewProvider {
    static var previews: some View {
        OldTabBar()
            .environmentObject(Model())
            .previewInterfaceOrientation(.portrait)
    }
}
