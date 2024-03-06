//
//  SearchView.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var show = false
    @Namespace var namespace
    @State var showStatusBar = true
    @State var selectedIndex = 0
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("showModal") var showModal = false
    
    var body: some View {
        ScrollView {
            VStack {
                content
                Spacer()
            }
            .padding(20)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .strokeStyle(cornerRadius: 30)
            .padding(20)
            .background(
                Rectangle()
                    .fill(.regularMaterial)
                    .frame(height: 200)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .blur(radius: 20)
                    .offset(y: -200)
            )
            .background(
                Image("Blob 1").offset(x: -100, y: -200)
            )
        }
        .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Rooftops, Cafe Dates, Late Nights...")) {
            ForEach(recommendations) { recommendation in
                Button {
                    text = recommendation.text
                    show.toggle()
                } label: {
                    Text(recommendation.text)
                        .searchCompletion(recommendation.text)
                }
            }
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
//        .fullScreenCover(isPresented: $show){
//            ItineraryView(namespace: namespace, post: posts[selectedIndex], show: $show)
//        }
        .statusBar(hidden: false)
//        .statusBar(hidden: true)
//        .onAppear {
//            self.showStatusBar = false
//        }
//        
//        .onDisappear {
//            self.showStatusBar = true
//        }
    }
    
    var content: some View {
        ForEach(Array(demoPosts.enumerated()), id: \.offset) { index, item in
            if item.title.contains(text) || text == "" {
                if index != 0 { Divider() }
                Button {
                    show = true
                    selectedIndex = index
                } label: {
                    HStack(alignment: .top, spacing: 12) {
                        Image(item.media[0])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .background(Color("Background"))
                            .mask(Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title).bold()
                                .foregroundColor(.primary)
                            Text(item.caption ?? "")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
