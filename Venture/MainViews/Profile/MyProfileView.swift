//
//  MyProfile.swift
//  Venture
//
//  Created by Lawrence Liu on 3/2/24.

import SwiftUI
import Firebase
import FirebaseFirestore

struct MyProfileView: View {
    
    @State var selectedTab: String = "posts"
    @Namespace var animation
    @Environment(\.colorScheme) var scheme
    @State var hasScrolled = false
    
    @State var topHeaderOffset: CGFloat = 0
    var profile: ProfileModel
    
    
    @State var selection = ""
    @State var likedItems: [Bool]
    
    
    //Firebase syncing
    @AppStorage("log_status") var logStatus: Bool = false
    @State var errorMessage: String = ""
    @State var showError: Bool = false
    @State var isLoading: Bool = false
    
    
    // Customized per profile
    @State private var myProfile: User?
    @State private var fetchedPosts: [Post] = []
    @AppStorage("user_UID") private var userUID: String = ""

    init(profile: ProfileModel) {
        self.profile = profile
        _likedItems = State(initialValue: Array(repeating: false, count: profile.bucketList.count))
    }

    var body: some View {
        ZStack {
            //Color("Background").ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false, content: {
                scrollDetection
                ProfileBlurb(user: myProfile ?? demoUserEmpty)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        TabBarButton(text: "Experiences", selectedTab: $selectedTab, identifier: "posts")
                        TabBarButton(text: "Down to Go", selectedTab: $selectedTab, identifier: "downtogo")
                    }
                    .offset(y: 14)
                    .frame(height: 52 ) // You can adjust this as necessary

                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)


                
                switch selectedTab {
                    case "posts":
                        PersonalFeedView(posts: $fetchedPosts)
                    case "downtogo":
                        bucketList
                default:
                    PersonalFeedView(posts: $fetchedPosts)
                }
                
                //Empty View just to be able to scroll down fully
                Group{
                    Text("")
                }
                .frame(height: 160)
            })
            .scrollClipDisabled()
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .frame(maxHeight: .infinity)
            .overlay(NavigationBar(title: "Profile", context: "profile", hasScrolled: $hasScrolled))
            
            //Loading overlay, copy and paste
            .overlay {
                LoadingView(show: $isLoading)
            }
            
            
            //Error alert overlay, copy and paste
            .alert(errorMessage, isPresented: $showError){
                
            }
            
            //Fetching data
            .task {
                if myProfile != nil{return}
                
                await fetchUserData()
            }
            .refreshable {
                myProfile = nil
                await fetchUserData()
            }
            
        }
        
        
    }
    
    //Fetching user data
    func fetchUserData() async {
        guard let userUID = Auth.auth().currentUser?.uid else {return}
        let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self)
        
        await MainActor.run(body: {
            myProfile = user
        })
    }
    
    //Setting the error for profile
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            isLoading = false
            errorMessage = error.localizedDescription
            showError.toggle()
        })
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
        NotReadyView()
    }
    
//    var bucketList: some View {
//        
//        VStack {
//            Text("Public Bucket List")
//                .font(.title3)
//                .fontWeight(.semibold)
//                .padding(.top, 20)
//                .padding(.bottom, 10)
//            VStack() {
//                ForEach(Array(profile.bucketList.enumerated()), id: \.offset) { index, item in
//                    if index != 0 { Divider() }
//                    HStack {
//                        Image(systemName: likedItems[index] ? "heart.fill" : "heart") // Replace with the actual heart icon image if it's not a system image
//                            .font(.body.weight(.bold))
//                            .frame(width: 36, height: 36)
//                            .foregroundColor(likedItems[index] ? .red : .secondary)
//                            .background(.ultraThinMaterial, in: Circle())
//                            .strokeStyle(cornerRadius: 14)
//
//                        
//                        
//                        Text(item)
//                            .fontWeight(.regular)
//                            .opacity(0.8)
//                        
//                        Spacer()
//                    }
//                    .onTapGesture(count: 2){
//                         // Toggle the liked state when the heart icon is tapped
//                         likedItems[index].toggle()
//                     }
//
//                    .padding(.vertical, 8)
//                    .padding(.horizontal)
//                }
//            }
//            .padding()
//            //.background(RoundedRectangle(cornerRadius: 30).fill(Color("Overlay")))
//            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
//            .padding(.horizontal)
//            
//            Text("'D2G' Experiences")
//                .font(.title3)
//                .fontWeight(.semibold)
//                .padding(.top, 20)
//                .padding(.bottom, 10)
//            
//            
//            //Temporary hard coding
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 3), spacing: 0) {
//                
//                ImageView(image: "IMG_5136", width: (UIScreen.main.bounds.width) / 3)
//                    .frame(width: (UIScreen.main.bounds.width - 40) / 3, height: UIScreen.main.bounds.width / 3)
//            }
//
//            .overlay(
//                RoundedRectangle(cornerRadius: 30, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
//                    .stroke(Color.clear, lineWidth: 2)
//            )
//            .clipShape(RoundedRectangle(cornerRadius: 30))
//            .padding(10)
//            
//            Rectangle()
//                .foregroundColor(Color.black.opacity(0.0))
//                .frame(height: 75)
//        }
//        
//        
//    }
}


#Preview {
    MyProfileView(profile: profiles[1])
}

