    //
    //  ItineraryView.swift
    //  Venture
    //
    //  Created by Lawrence Liu on 1/11/24.
    //

    import SwiftUI

    struct ItineraryView: View {
        
        var post: PostModel = posts[0] // for preview
        
        var body: some View {
            Text("Hello world")
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
                            .frame(width: 30)
                    }
                    .frame(width: (UIScreen.main.bounds.width/2))

                }
                else {
                    Group {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 2)
                            .frame(width: 30)
                    }
                    .frame(width: (UIScreen.main.bounds.width/2))

                }
            }
        })
    }
    

}
