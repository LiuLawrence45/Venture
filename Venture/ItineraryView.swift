//
//  ItineraryView.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

struct ItineraryView: View {
    var namespace: Namespace.ID
    var post: PostModel = posts[0]
    @Binding var show: Bool
    @State var appear = [false, false, false]
    //@EnvironmentObject var model: Model
    @State var viewState: CGSize = .zero
    @State var isDraggable = true
    @State var showSection = false
    @State var selectedIndex = 0
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                    .padding(.bottom, 100)
                content
                    .opacity(appear[2] ? 1 : 0)
            }
            .coordinateSpace(name: "scroll")
            //.onAppear { model.showDetail = true }
            //.onDisappear { model.showDetail = false }
            .background(Color("Background"))
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3, style: .continuous))
            .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
            .scaleEffect(viewState.width / -500 + 1)
            .background(.black.opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isDraggable ? drag : nil)
            .ignoresSafeArea()
            
            button
        }
        .onAppear {
            fadeIn()
        }
        .onChange(of: show) { //newValue in
            //fadeOut() //Below is either true or false
            if (show == false) {
                fadeOut()
            }
        }
    }
    
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .foregroundStyle(.black)
            .background(
                Image(post.images[0])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background\(post.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    .blur(radius: scrollY / 10)
            )
            .mask(
                RoundedRectangle(cornerRadius: appear[0] ? 0 : 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(post.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            )
            .overlay(
                overlayContent
                    .offset(y: scrollY > 0 ? scrollY * -0.6 : 0)
            )
        }
        .frame(height: 500)
        .padding(.bottom, 20)
    }

    
    var content: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            //Event number 1
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("1. sunflowers @ bay family farms")
                        .font(.title3.weight(.semibold))
                    Text("don't forget to make a reservation on their website: andreottifamilyfarms.com")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("for entrance and 5 flowers, its $15 per adult, $10 per kid. really really worth it though")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("wear bad shoes--it gets muddy easily")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .strokeStyle(cornerRadius: 30)
            
            // Event Number 2
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("2. pumpkin patch @ moss beach")
                        .font(.title3.weight(.semibold))
                    Text("like 30 mins away from half mooon bay. we took a small detour.")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("arata's pumpkin patch is around $10 per adult--not so fun though, keep your money")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("good homemade honey though, definitely buy.")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .strokeStyle(cornerRadius: 30)
            
        }
        .padding(20)
        
    }
    
    var button: some View {
        Button {
            withAnimation(.closeCard) {
                show.toggle()
                //model.showDetail.toggle()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .ignoresSafeArea()
    }
    
    var overlayContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(post.title)
                .font(.largeTitle.weight(.bold))
                .matchedGeometryEffect(id: "title\(post.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(post.info.uppercased())
                .font(.footnote.weight(.semibold))
                .matchedGeometryEffect(id: "subtitle\(post.id)", in: namespace)
            Text(post.caption)
                .font(.footnote)
                .matchedGeometryEffect(id: "text\(post.id)", in: namespace)
            Divider()
                .opacity(appear[0] ? 1 : 0)
            HStack {
                Image("Avatar Default")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .cornerRadius(10)
                    .padding(8)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .strokeStyle(cornerRadius: 18)
                Text("Itinerary edited by Lawrence Liu and Jacob Nguyen")
                    .font(.footnote)
            }
            .opacity(appear[1] ? 1 : 0)
        }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .matchedGeometryEffect(id: "blur\(post.id)", in: namespace)
            )
            .offset(y: 250)
            .padding(20)
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                guard value.translation.width > 0 else { return }
                
                if value.startLocation.x < 100 {
                    withAnimation(.closeCard) {
                        viewState = value.translation
                    }
                }
                
                if viewState.width > 120 {
                    close()
                }
            }
            .onEnded { value in
                if viewState.width > 80 {
                    close()
                } else {
                    withAnimation(.closeCard) {
                        viewState = .zero
                    }
                }
            }
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
    
    func close() {
        withAnimation(.closeCard.delay(0.3)) {
            show.toggle()
            //model.showDetail.toggle()
        }
        
        withAnimation(.closeCard) {
            viewState = .zero
        }
        
        isDraggable = false
    }
}

//#Preview {
//    @Namespace static var namespace
//    ItineraryView(namespace: namespace, show: .constant(true))
//}

struct ItineraryView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ItineraryView(namespace: namespace, show: .constant(true))
            //.environmentObject(Model())
    }
}
