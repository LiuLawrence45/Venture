//
//  ItineraryView.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI
import SDWebImageSwiftUI



//Typical spacing in this is multiples of 8: Most is 8 spacing, but between Footer and below is 32.

struct ItineraryView: View {
    @Environment(\.dismiss) var dismiss
    
    var post: Post
    @State var selectedTab: String = "main"
    @EnvironmentObject var model: Model
    
    
    //Cropping tools
    @State private var selectedImageForCropping: UIImage? = nil
    @State private var showingImageCropper: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    
                    TabView {
                        ForEach(post.imageURLs, id: \.self){ imageURL in
                            ZStack {
                                HStack {
                                    Spacer()
                                    WebImage(url: imageURL)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
    //                                    .frame(width: UIScreen.main.bounds.width - 16, height: 480)
                                        .frame(width: 384, height: 480)
                                        .clipped()
                                    
                                    Spacer()
                                }

                                    
                            }
                            
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 480)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 8)
                    
                    ItineraryFooter(post: post)
                        .padding(.bottom, 16)
                    
                    //Significant Padding. Here is the Tab Bar
                    HStack(spacing: 0) {
                        ItineraryTabBarButton(text: "Summary", selectedTab: $selectedTab, identifier: "main")
                        ItineraryTabBarButton(text: "Discussion", selectedTab: $selectedTab, identifier: "discussion")
                    }
                    .padding(.bottom, 16)
                    
                    //Tab Switches
                    switch selectedTab {
                    case "posts":
                        summary(post: post)
                    case "discussion":
                        discussion

                    default:
                        summary(post: post)
                    }
                    

                    Spacer()
                    

                }
                
            }
            if selectedTab == "discussion" {
                VStack {
                    Spacer()
//                    floatingCommentBar
                            .transition(.move(edge: .bottom).combined(with: .opacity)) // Smooth transition for appearing
                            .animation(.easeInOut, value: selectedTab) // Animate the transition
                    }
            }
        }
        .edgesIgnoringSafeArea(.bottom) // Ensure the floating bar can extend to the bottom edge of the screen
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Label("Back", systemImage: "chevron.backward")
                }

            }


        }
        .tint(.primary)
        
    }

    
}

//var floatingCommentBar: some View {
//        HStack(alignment: .bottom){
//            
//            NavigationLink(destination: MyProfileView()){
//                Image(profiles[0].profilePicture)
//                    .resizable()
//                    .frame(width: 36, height: 36)
//                    .mask(Circle())
//                    .padding(.leading, 20)
//            }
//            .accentColor(.primary)
//              
//            
//            
//            Button {
//                
//            } label: {
//                Text("_Add a Comment..._")
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(10)
//                    .opacity(0.3)
//                    .font(.footnote)
//                    .accentColor(.primary)
//                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
//                    .padding(.trailing, 20)
//            }
//
//
//        }
//        .padding(.bottom, 15)
//        .padding(.top, 10)
//        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 0, style: .continuous))
//
//}


//Content to overfill the discussion
var discussion: some View {
   
    
    VStack {
        
        NotReadyView()
//        CommentsView()
//            .padding(.bottom, 8)
//        CommentsView()
//            .padding(.bottom, 8)
//        CommentsView()
//            .padding(.bottom, 8) 
        
        Group {
            Text("")
                .frame(height: 200)
        }
    }

}

//Content to overfill the summmary
struct summary: View {
    var post: Post
    var body: some View {
        Text(post.tripItinerary)
            .padding(.horizontal, 8)
            
        
        Group {
            Text("")
                .frame(height: 200)
        }
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
//                    .font(.system(size: 14, weight: .medium)) // Customize the font as needed
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundColor(selectedTab == identifier ? .primary : .secondary)
                
                // Conditionally show underline only under the selected tab
                if selectedTab == identifier {
                    Group {
                        Rectangle()
                            .fill(Color.primary)
                            .frame(height: 2)
                            .frame(width: UIScreen.main.bounds.width/2-16)
                    }
                    .frame(width: (UIScreen.main.bounds.width/2))

                    
                }
                else {
                    Group {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 2)
                            .frame(width: UIScreen.main.bounds.width/2-16)
                    }
                    .frame(width: (UIScreen.main.bounds.width/2))
                    
                }
            }
        })
    }
    
    
}


//struct ItineraryView_Previews: PreviewProvider {
//    
//    @Namespace static var namespace
//    
//    static var previews: some View {
//        ItineraryView()
//        .environmentObject(Model())
//    }
//}



// IDEAS FOR SUMMARY


//        HStack {
//            Image(systemName: "diamond")
//            VStack {
//                Text("Community Hero")
//                    .font(.callout)
//                    .fontWeight(.semibold)
//                Text("Lawrence's itinerary has gotten the most likes this week. ")
//                    .font(.caption)
//
//            }
//        }

//Left Alignment
//        HStack(spacing: 0){
//            Text("Cost: ")
//                .fontWeight(.semibold)
//            Text("$16")
//            Spacer()
//        }
//        .font(.callout)
//
//        .padding(.leading, 2)



