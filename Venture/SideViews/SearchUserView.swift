//
//  SearchView.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI
import Firebase

struct SearchUserView: View {
    
    // View Properties, for searching users
    @State private var fetchedUsers: [User] = []
    @State private var searchText: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            ForEach(fetchedUsers) { user in
                NavigationLink {
                    if (user.userUID != nil){
                        OthersProfileView(myProfile: user, uid: user.userUID!)
                    }
                    else {
                        Group {
                            Text ("User userUID not found: \(user.userUID)")
                        }

                    }

                } label: {
                    HStack {
                        Text(user.username)
                            .font(.callout)
                        Spacer()
                    }

                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Search Users")
        .searchable(text: $searchText)
        
        //First time, showing top recommended users
        .onAppear {
            Task {await fetchTopUsers()}
        }
        
        //When user submits a query
        .onSubmit(of: .search, {
            Task {await searchUsers()}
        })
        
        //Whenever the searchText is submitted / changed
        .onChange(of: searchText, perform: { newValue in
            if newValue.isEmpty {
                fetchedUsers = []
            }
        })
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
    
    
    func searchUsers() async {
        do {
            let queryLowerCased = searchText.lowercased()
            let queryUpperCased = searchText.uppercased()
            
            // Execute the query
            let snapshot = try await Firestore.firestore().collection("Users")
                .whereField("username", isGreaterThanOrEqualTo: queryUpperCased)
                .whereField("username", isLessThanOrEqualTo: "\(queryLowerCased)\u{f8ff}")
                .getDocuments()

            // Map documents to users
            let users = try snapshot.documents.compactMap { doc -> User? in
                try doc.data(as: User.self)
            }
            
            await MainActor.run {
                fetchedUsers = users
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchTopUsers() async {
        do {
            // Adjust the query to fetch top 40 users. This might need to be adapted based on your database structure
            let snapshot = try await Firestore.firestore().collection("Users")
                .limit(to: 40) // Limits the query to the top 40 users
                .getDocuments()

            let users = try snapshot.documents.compactMap { doc -> User? in
                try doc.data(as: User.self)
            }
            
            await MainActor.run {
                fetchedUsers = users
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

struct SearchUserView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserView()
    }
}
