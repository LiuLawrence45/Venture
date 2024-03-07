//
//  NotReadyView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/6/24.
//

import SwiftUI

struct NotReadyView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Group {
            Text("Under development. Come back soon! :P")
        }
        .padding(16)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .topBarLeading) {
//                Button(action: {
//                    dismiss()
//                }) {
//                    Label("Back", systemImage: "chevron.backward")
//                }
//                .tint(.primary)
//                
//            }
//        }
//        .foregroundColor(.white)
    }
}

#Preview {
    NotReadyView()
}
