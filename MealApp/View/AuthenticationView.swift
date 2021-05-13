//
//  AuthenticationView.swift
//  MealApp
//
//  Created by Isha on 02/05/21.
//  Copyright © 2021 Isha. All rights reserved.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var authState: AuthenticationState
       @State var authType = AuthenticationType.login
    
    var body: some View {
        ZStack {
            Color.appBackgroundColor.edgesIgnoringSafeArea(.all)
            VStack() {
                WelcomeText()
                UserImage()
                
                if (!authState.isAuthenticating) {
                    AuthenticationFormView(authType: $authType)
                } else {
                    if #available(iOS 14.0, *) {
                        ProgressView()
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }.padding()
            
            .background(Color.appBackgroundColor)

        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
