//
//  ParentView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/2/24.
//

import SwiftUI

struct ParentView: View {
    @EnvironmentObject var model: Model

    var body: some View {
        switch model.selectedModal {
        case .signIn:
            SigninView()
                .environmentObject(model)
        case .signUp:
            SignupView(dismissModal: {})
                .environmentObject(model)
        }
    }
}