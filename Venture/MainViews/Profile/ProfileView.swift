//
//  ProfileView.swift
//  Venture
//
//  Created by Lawrence Liu on 1/12/24.
//

import SwiftUI

struct ProfileView: View {
    
    @State var selectedTab: String = "posts"
    @Namespace var animation
//    @Environment(\.colorScheme) var scheme
    @State var hasScrolled = false
    
    
    @State var topHeaderOffset: CGFloat = 0
    var profile: ProfileModel //Dynamic Profile

    
    @State var selection = ""
    
    
    // Add a state variable to track liked items for the bucket list
    // Initialize with false for each item, assuming you have the count of bucketList items
    @State var likedItems: [Bool]

    // Modify your initializer to initialize likedItems based on the bucketList count
    init(profile: ProfileModel) {
        self.profile = profile
        _likedItems = State(initialValue: Array(repeating: false, count: profile.bucketList.count))
    }
    
    


    var body: some View {
        ZStack {
//            Color("Background").ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false, content: {
                scrollDetection 
                
                ProfileBlurb(user: demoUser)
                    .padding(.horizontal, 10)
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        TabBarButton(text: "Experiences", selectedTab: $selectedTab, identifier: "posts")
                        TabBarButton(text: "Down to Go", selectedTab: $selectedTab, identifier: "downtogo")
                    }
                    .offset(y: 14)
                    .frame(height: 52 ) // You can adjust this as necessary
                    

                    //PostView
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading) // This ensures there is no extra space on the sides
                
                switch selectedTab {
                    case "posts":
                        PostsView
                    case "downtogo":
                        bucketList
                default:
                    PostsView
                }
            })
//            .scrollClipDisabled() //iOS 17.0
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 0)
            }
            //.background(Image("Blob 1").offset(x: -100, y: -400))
        }
        
        
    }
    
    
    var scrollDetection: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeInOut) {
                if value < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
    }
    
    var bucketList: some View {
        
        VStack {
            Text("Under Development! Come back soon :P")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top, 20)
                .padding(.bottom, 10)
        }
        
        
    }
}


var PostsView: some View {
    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 3), spacing: 0) {
        
        ImageView(image: "Bingsuu!", width: (UIScreen.main.bounds.width) / 3)
            .frame(width: (UIScreen.main.bounds.width - 40) / 3, height: UIScreen.main.bounds.width / 3)
        ImageView(image: "IMG_7533", width: (UIScreen.main.bounds.width) / 3)
            .frame(width: (UIScreen.main.bounds.width - 40) / 3, height: UIScreen.main.bounds.width / 3)
        ImageView(image: "DSCN1352", width: (UIScreen.main.bounds.width) / 3)
            .frame(width: (UIScreen.main.bounds.width - 40) / 3, height: UIScreen.main.bounds.width / 3)
    }

    .overlay(
        RoundedRectangle(cornerRadius: 30, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
            .stroke(Color.clear, lineWidth: 2)
    )
    .clipShape(RoundedRectangle(cornerRadius: 30))
    .padding(10)


//    .padding(20)
//    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
//    .strokeStyle(cornerRadius: 30)
//    .padding(.horizontal, 20)
    
}

struct ImageView: View {
    
    //var index: Int
    var image: String
    var width: CGFloat

    
    var body: some View {
        Image(image)
        //Image("Background \(index)")
            .resizable()
            .scaledToFill() // This will fill the frame while maintaining the aspect ratio
            .frame(width: width, height: width)
            .clipped() // This will clip the overflowed part of the image
    }
}


#Preview {
    ProfileView(profile: profiles[1])
}


struct TabBarButton: View {
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
