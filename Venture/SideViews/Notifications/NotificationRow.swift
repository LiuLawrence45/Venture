//
//  NotificationRow.swift
//  Venture
//
//  Created by Lawrence Liu on 1/12/24.
//

import SwiftUI

struct NotificationRow: View {
    var section: NotificationInformation = notificationInformation[0]
    var body: some View {
        HStack(spacing: 16) {
            Image("Avatar Default")
//            Image(section.logo)
                .resizable()
                .frame(width: 36, height: 36)
                .mask(Circle())

//                .overlay(CircularView(value: section.progress))
            
            
            VStack(alignment: .leading, spacing: 4 ) {
                Spacer()
                HStack {
                    
                }
                Text(section.name)
                    .fontWeight(.semibold)
                Text(section.action)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                Spacer()
         
            }
            Spacer()
            Image(section.image)
                .resizable()
                .frame(width: 48, height: 48)
                .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
            

//                ProgressView(value: section.progress)
//                    .accentColor(.white)
//                    .frame(maxWidth: 132)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 0)
    }
}

#Preview {
    NotificationRow()
}
