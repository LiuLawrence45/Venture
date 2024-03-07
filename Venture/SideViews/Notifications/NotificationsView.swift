//
//  NotificationsView.swift
//  Venture
//
//  Created by Lawrence Liu on 1/12/24.
//

import SwiftUI



struct NotificationsView: View {
    
    @Binding var hasScrolled: Bool
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                content
            }
            .padding(20)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .strokeStyle(cornerRadius: 30)
            .padding(20)
            .background(
                Rectangle()
                    .fill(.regularMaterial)
                    .frame(height: 200)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .blur(radius: 20)
                    .offset(y: -200)
            )
            .background(
                Image("Blob 1").offset(x: -100, y: -200)
            )
        }
        .navigationTitle("Notifications")
        //.navigationBarTitleDisplayMode(.inline)
        
    }
    
    
    var content: some View {
        ForEach(Array(notificationInformation.enumerated()), id: \.offset) { index, item in
            if index != 0 { Divider() }
            HStack(alignment: .top, spacing: 12) {
                
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44, height: 44)
                    .background(Color("Background"))
                    .mask(Circle())
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name).bold()
                        .foregroundColor(.primary)
                    Text(item.action)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.vertical, 8)
            .listRowSeparator(.hidden)
        }
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
    }
    
}

#Preview {
    NotificationsView(hasScrolled: .constant(false))
}
