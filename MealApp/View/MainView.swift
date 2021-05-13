//
//  MainView.swift
//  MealApp
//
//  Created by Isha on 02/05/21.
//  Copyright © 2021 Isha. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authState: AuthenticationState
    func listen() {
               authState.listen()
           }

    var body: some View {
        VStack{
            if authState.loggedInUser != nil {
                  MainTabView()   //ContentView(viewModel: CategoryListViewModel(), viewFoodModel: CategoryFoodListViewModel())
            } else {
                AuthenticationView(authType: .login)
            }
        }
//            .animation(.easeInOut)
//            .transition(.move(edge: .bottom))
        }
    }


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
