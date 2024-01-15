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
                    .padding(20)
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        TabBarButton(image: "person.3.fill", isSystemImage: true, animation: animation, selectedTab: $selectedTab, identifier: "posts")
                        TabBarButton(image: "text.justify", isSystemImage: true, animation: animation, selectedTab: $selectedTab, identifier: "downtogo")
                    }
                    .offset(y: 14)
                    .frame(height: 53) // You can adjust this as necessary
                    

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
                
                //bucketList
                

                
                //likedExperiences
            })
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .overlay(NavigationBar(title: "Profile", hasScrolled: .constant(true)))
            .background(Image("Blob 1").offset(x: -100, y: -400))
        }
        
        
    }
    
    var bucketList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(posts) { course in
                    //SmallCourseItem(course: course)
                }
            }
            .padding(.horizontal, 20)
            Spacer()
        }
    }
    
    var likedExperiences: some View {
        VStack {
            ForEach(posts) { topic in
                //ListRow(topic: topic)
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
}


var PostView: some View {
    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 3), spacing: 0) {
        ForEach(1...9, id: \.self) { index in // Assuming you want to display images 1 through 9
            ImageView(index: index, width: UIScreen.main.bounds.width / 3)
                .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
        }
    }
    
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
    var image: String
    var isSystemImage: Bool
    var animation: Namespace.ID
    @Binding var selectedTab: String
    var identifier: String
    var body: some View {
        
        Button(action: {
            withAnimation(.easeInOut(duration: 0.1)){
                selectedTab = image
            }
        }, label: {
            VStack(spacing: 12){
                
                (
                    isSystemImage ? Image(systemName: image)  : Image(image)
                )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28)
                .foregroundColor(selectedTab == image ? .primary : .secondary)
            
                
                ZStack {
                    if selectedTab == image {
                        Rectangle()
                            .fill(Color.primary)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                    else {
                        Rectangle()
                            .fill(Color.secondary)
                    }
                }
                .frame(height: 1)
                
            }
        })
        
    }
    
}
