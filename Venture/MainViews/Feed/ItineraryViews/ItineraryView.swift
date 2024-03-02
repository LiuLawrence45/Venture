//
//  ItineraryView.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI



//Typical spacing in this is multiples of 8: Most is 8 spacing, but between Footer and below is 32.

struct ItineraryView: View {
    
    var post: PostModel = posts[0] // for preview
    @State var selectedTab: String = "main"
    
    var body: some View {
        ZStack {
            ScrollView {
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
                        .frame(height: 480)
                        .padding(.bottom, 8)
                    ItineraryFooter(post: posts[0])
                        .padding(.bottom, 16)
        //            Divider()
        //                .padding(.vertical, 8)
                    
                    //Significant Padding. Here is the Tab Bar
                    HStack(spacing: 0) {
                        ItineraryTabBarButton(text: "Summary", selectedTab: $selectedTab, identifier: "main")
                        ItineraryTabBarButton(text: "Discussion", selectedTab: $selectedTab, identifier: "discussion")
                    }
                    .padding(.bottom, 16)
                    switch selectedTab {
                    case "posts":
                        summary
                    case "discussion":
                        discussion
        //                ItineraryMapView()
        //                    .frame(height: 50)
                    default:
                        summary
                    }
                    Spacer()
                }
                
            }
            if selectedTab == "discussion" {
                VStack {
                    Spacer()
                    floatingCommentBar
                            .transition(.move(edge: .bottom).combined(with: .opacity)) // Smooth transition for appearing
                            .animation(.easeInOut, value: selectedTab) // Animate the transition
                    }
            }
        }
        .edgesIgnoringSafeArea(.bottom) // Ensure the floating bar can extend to the bottom edge of the screen 

        
        
    }
    
}

var floatingCommentBar: some View {
        HStack(alignment: .bottom){
            
            NavigationLink(destination: ProfileView(profile: profiles[0])){
                Image(profiles[0].profilePicture)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .mask(Circle())
                    .padding(.leading, 20)
            }
            .accentColor(.primary)
              
            
            
            Button {
                
            } label: {
                Text("_Add a Comment..._")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .opacity(0.3)
                    .font(.footnote)
                    .accentColor(.primary)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .padding(.trailing, 20)
            }


        }
        .padding(.bottom, 15)
        .padding(.top, 10)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 0, style: .continuous))

}


//Content to overfill the discussion
var discussion: some View {
   
    
    VStack {
        CommentsView()
            .padding(.bottom, 8)
        CommentsView()
            .padding(.bottom, 8)
        CommentsView()
            .padding(.bottom, 8) 
    }

}

//Content to overfill the summmary
var summary: some View {
    VStack(){
        
        // Fill with "post_summary" after.
        Text("Escape to our oceanfront sanctuary, just 15 minutes from SF and SFO. Set on the second floor of a duplex, the large windows offer breathtaking ocean views.")
            .font(.footnote)
            .multilineTextAlignment(.leading)
        
        Divider()
            .padding(.vertical, 8)
        
        // Fill with "pay_details" after. Should be a formatted list. Padding is 8 between each section. From header to words underneath, padding is 6.
        Text("Payment Details")
            .fontWeight(.bold)
            .padding(.bottom, 6)
        Text("**1.** ZipCar was pretty expensive. Ordering from ZipCar costed around $30.\n**2.** The site was $50\n**3.** Food costed around a lot of money.")
            .font(.footnote)
            .multilineTextAlignment(.leading)
            .padding(.bottom, 8)
        
        Text("Travel Details ")
            .fontWeight(.bold)
            .padding(.bottom, 6)
        Text("**1.** ZipCar was pretty expensive. Ordering from ZipCar costed around $30.\n**2.** The site was $50\n**3.** Food costed around a lot of money.")
            .font(.footnote)
            .multilineTextAlignment(.leading)
            .padding(.bottom, 8)
        
        Text("Organization Details ")
            .fontWeight(.bold)
            .padding(.bottom, 6)
        Text("**1.** ZipCar was pretty expensive. Ordering from ZipCar costed around $30.\n**2.** The site was $50\n**3.** Food costed around a lot of money.")
            .font(.footnote)
            .multilineTextAlignment(.leading)
        
        Divider()
            .padding(.vertical, 8)
        
        Text("Stop 1: San Gregorio Beach")
            .fontWeight(.bold)
            .padding(.bottom, 6)
        Text("Totally a really great time. I understood the waves and they splashed so big! San Gregorio is so cool!")
            .font(.footnote)
            .multilineTextAlignment(.leading)
            .padding(.bottom, 8)
        
        Text("Stop 2: Venture Retreat Center")
            .fontWeight(.bold)
            .padding(.bottom, 6)
        Text("Totally a really great time. I understood the waves and they splashed so big! San Gregorio is so cool!")
            .font(.footnote)
            .multilineTextAlignment(.leading)
            .padding(.bottom, 8)
        
        Text("Stop 3: Half-Moon Bay")
            .fontWeight(.bold)
            .padding(.bottom, 6)
        Text("Totally a really great time. I understood the waves and they splashed so big! Half-Moon Bay is so cool!")
            .font(.footnote)
            .multilineTextAlignment(.leading)
            .padding(.bottom, 8)
        
        
        
    }
    .padding(.horizontal, 8)

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
                    .font(.system(size: 14, weight: .medium)) // Customize the font as needed
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


struct ItineraryView_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        ItineraryView()
        //.environmentObject(Model())
    }
}



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



