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
                        .padding(.bottom, 80 )
                    content
                        .opacity(appear[2] ? 1 : 0)
                }
                .coordinateSpace(name: "scroll")
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
            .statusBar(hidden: true)
            

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
                    ZStack {
                        Image(post.media[0])
                            .resizable()
                            //.aspectRatio(contentMode: .fill)
                            .scaledToFill()
                            .matchedGeometryEffect(id: "background\(post.id)", in: namespace)
                            .offset(y: scrollY > 0 ? -scrollY : 0)
                            .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                            .blur(radius: scrollY / 10)
                            
                        
                        VStack {
                            Spacer()
                            VStack(alignment: .center, spacing: 12) {
                                Group {   
                                    Text(post.title)
                                        //.animatableFont(size: 34, weight: .bold )
                                        .font(.title.weight(.bold))
                                        .matchedGeometryEffect(id: "title\(post.id)", in: namespace)
                                        //.opacity(0.5)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    Text(post.caption ?? "")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        //.opacity(0.5)
                                        .matchedGeometryEffect(id: "text\(post.id)", in: namespace)
                                    
                                    HStack {
                                        Image("IMG_5155")
                                            .resizable()
                                            .frame(width: 26, height: 26)
                                            .mask(Circle())
//                                            .cornerRadius(10)
//                                            .padding(8)
//                                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
//                                            .strokeStyle(cornerRadius: 18)
                                        Text("Itinerary edited by Katie Cheng") 
                                            .font(.footnote)
                                    }
                                    .opacity(appear[1] ? 1 : 0)
                                }
                                .offset(y: -20)

                            }
                            .padding(20)
                            .background(
                                Rectangle()
                                    .fill(.ultraThinMaterial)
                                    .blur(radius: 50 )
                                    .matchedGeometryEffect(id: "blur\(post.id)", in: namespace)
                            )
                        }
                        .foregroundStyle(.white)
                    }

                )
                .mask(
                    RoundedRectangle(cornerRadius: appear[0] ? 0 : 0, style: .continuous)
                        .matchedGeometryEffect(id: "mask\(post.id)", in: namespace)
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                )
            }
            .frame(height: 430 )

        }

        
        var content: some View {
            PostItineraryDescription(itinerary: post.itinerary)
            
        }
        
        var button: some View {
            Button {
                withAnimation(.closeCard) {
                    show.toggle()
                    //model.showDetail.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    //.resizable()
                    //.frame(width: 20, height: 20)
                    .font(.body.weight(.bold))
                    .foregroundColor(.primary)
                    .padding(8)
                    //.opacity(0.2)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .ignoresSafeArea()
        }
        
        var drag: some Gesture {
            
            DragGesture()
                .onChanged { value in
                    viewState = value.translation
                }
                .onEnded { value in
                    if value.translation.height > 200 {
                        close()
                    }
                }
//            DragGesture(minimumDistance: 30, coordinateSpace: .local)
//                .onChanged { value in
//                    guard value.translation.width > 0 else { return }
//                    if value.startLocation.x < 100 {
//                        withAnimation(.closeCard) {
//                            viewState = value.translation
//                        }
//                    }
//                    
//                    if viewState.width > 120 {
//                        close()
//                    }
//                }
//                .onEnded { value in
//                    if viewState.width > 80 {
//                        close()
//                    } else {
//                        withAnimation(.closeCard) {
//                            viewState = .zero
//                        }
//                    }
//                }
        }
        
        func fadeIn() {
            withAnimation(.linear) {
                appear[0] = true
            }
            withAnimation(.linear) {
                appear[1] = true
            }
            withAnimation(.linear) {
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

    struct ItineraryView_Previews: PreviewProvider {
        @Namespace static var namespace
        
        static var previews: some View {
            ItineraryView(namespace: namespace, show: .constant(true))
                //.environmentObject(Model())
        }
    }
