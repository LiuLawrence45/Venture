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
        
        .onSubmit(of: .search, {
            Task {await searchUsers()}
        })
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
    
}

struct SearchUserView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserView()
    }
}
