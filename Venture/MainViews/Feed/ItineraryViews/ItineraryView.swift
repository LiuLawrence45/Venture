    //
    //  ItineraryView.swift
    //  Venture
    //
    //  Created by Lawrence Liu on 1/11/24.
    //

    import SwiftUI

    struct ItineraryView: View {
        
        var post: PostModel = posts[0] // for preview
        @State var selectedTab: String = "main"
        
        var body: some View {
            VStack {
                TabView {
                    ForEach(post.media, id: \.self) { mediaItem in

                        ZStack {
                            Image(mediaItem)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width)
                                .clipped()
                        }



                    }

                }.tabViewStyle(PageTabViewStyle())
                .padding(.horizontal, 8)
                .frame(height: 480)
                .padding(.bottom, 8)
                ItineraryFooter(post: posts[0])
                    .padding(.bottom, 32)   
                HStack(spacing: 0) {
                    ItineraryTabBarButton(text: "Summary", selectedTab: $selectedTab, identifier: "main")
                    ItineraryTabBarButton(text: "Map", selectedTab: $selectedTab, identifier: "map")
                    ItineraryTabBarButton(text: "Comments", selectedTab: $selectedTab, identifier: "comments")
                }
                
//                Divider()
//                    .padding(.vertical, 8)
                Spacer()
            }


            
        }
    }

    struct ItineraryView_Previews: PreviewProvider {
        
        @Namespace static var namespace
        
        static var previews: some View {
            ItineraryView()
                //.environmentObject(Model())
        }
    }



struct ItineraryTabBarButton: View {
    var text: String // New property for text
    @Binding var selectedTab: String
    var identifier: String
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.1)){
                selectedTab = identifier // Use identifier for selection logic
            }
        }, label: {
            VStack(spacing: 4 ){
                Text(text) // Use Text instead of Image
                    .font(.system(size: 14, weight: .bold)) // Customize the font as needed
                    .foregroundColor(selectedTab == identifier ? .primary : .secondary)
                
                // Conditionally show underline only under the selected tab
                if selectedTab == identifier {
                    Group {
                        Rectangle()
                            .fill(Color.primary)
                            .frame(height: 2)
                            .frame(width: UIScreen.main.bounds.width/3)
                    }
                    .frame(width: (UIScreen.main.bounds.width/3))

                }
                else {
                    Group {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 2)
                            .frame(width: UIScreen.main.bounds.width/3)
                    }
                    .frame(width: (UIScreen.main.bounds.width/3))

                }
            }
        })
    }
    

}
