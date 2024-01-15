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
    @Environment(\.colorScheme) var scheme
    
    @State var topHeaderOffset: CGFloat = 0
    
    init() {
        
        UIPickerView.appearance().backgroundColor = .clear
    }
    
    
    @State var selection = ""
    var body: some View {
         
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                ProfileBlurb()
                    .padding(.horizontal, 10)
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        TabBarButton(text: "Posts", selectedTab: $selectedTab, identifier: "posts")
                        TabBarButton(text: "Down to Go", selectedTab: $selectedTab, identifier: "downtogo")
                    }
                    .offset(y: 14)
                    .frame(height: 52 ) // You can adjust this as necessary
                    

                    //PostView
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading) // This ensures there is no extra space on the sides
                
                switch selectedTab {
                    case "posts":
                        PostView
                    case "downtogo":
                        bucketList
                default:
                    PostView
                }
            })
            .scrollClipDisabled()
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .overlay(NavigationBar(title: "Profile", hasScrolled: .constant(true)))

            //.background(Image("Blob 1").offset(x: -100, y: -400))
        }
        
        
    }
    
    var bucketList: some View {
        
        VStack {
            Text("Public Bucket List")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top, 20)
                .padding(.bottom, 10)
            VStack() {
                ForEach(Array(bucketListItems.enumerated()), id: \.offset) { index, item in
                    if index != 0 { Divider() }
                    HStack {
                        Image(systemName: "heart.fill") // Replace with the actual heart icon image if it's not a system image
                            .font(.body.weight(.bold))
                            .frame(width: 36, height: 36)
                            .foregroundColor(.secondary)
                            .background(.ultraThinMaterial, in: Circle())
                        .strokeStyle(cornerRadius: 14)

                        
                        
                        Text(item)
                            .fontWeight(.regular)
                            .opacity(0.8)
                        
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                }
            }
            .padding()
            //.background(RoundedRectangle(cornerRadius: 30).fill(Color("Overlay")))
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .padding(.horizontal)
            
            Text("'D2G' Experiences")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            PostView
            
            Rectangle()
                .foregroundColor(Color.black.opacity(0.0))
                .frame(height: 75)
        }
        
        
    }

    let bucketListItems = ["2 AM Drive to Berkeley", "Late Night Beach Hopping", "Super Smash Bros on a Rooftop"]
    
}


var PostView: some View {
    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 3), spacing: 0) {
        ForEach(1...6, id: \.self) { index in // Assuming you want to display images 1 through 9
            ImageView(index: index, width: (UIScreen.main.bounds.width) / 3)
                .frame(width: (UIScreen.main.bounds.width - 40) / 3, height: UIScreen.main.bounds.width / 3)
            
        }
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
    
    var index: Int
    var width: CGFloat
    
    var body: some View {
        Image("Background \(index)")
            .resizable()
            .scaledToFill() // This will fill the frame while maintaining the aspect ratio
            .frame(width: width, height: width)
            .clipped() // This will clip the overflowed part of the image
    }
}


#Preview {
    ProfileView()
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
