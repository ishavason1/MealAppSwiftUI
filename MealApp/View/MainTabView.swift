//
//  MainTabView.swift
//  MealApp
//
//  Created by Isha on 12/05/21.
//  Copyright © 2021 Isha. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
   var tabItems = ["Home", "Search", "Favorities", "Settings"]
    @State var selected = "Home"
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection : $selected) {
                ContentView(viewModel: CategoryListViewModel(), viewFoodModel: CategoryFoodListViewModel())
                    .tag(tabItems[0])
                    .edgesIgnoringSafeArea([.top])
                Color.blue
                    .tag(tabItems[1])
                    .edgesIgnoringSafeArea([.top])
                    
                Color.green
                    .tag(tabItems[2])
                    .edgesIgnoringSafeArea([.top])
                AccountsView()
                    .tag(tabItems[3])
                    .edgesIgnoringSafeArea([.top])
               
            }
        
        // Custom TabBar ....
        HStack(spacing: 0) {
            ForEach(tabItems, id: \.self) { value in
                TabBarButton(selected: $selected, value: value)
                if value != tabItems.last{Spacer(minLength: 0)}
                
            }
        }
        .padding(.horizontal, 25)
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 0 : UIApplication.shared.windows.first?.safeAreaInsets.bottom )
        .background(Color.appButtonColor)
        }
        .edgesIgnoringSafeArea(.bottom)
        
}
    
}



struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainTabView()
            MainTabView()
        }
    }
}

struct TabBarButton: View {
    @Binding var selected: String
    var value: String
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selected = value
            }
        }, label: {
            VStack {
                Image(value)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 26, height: 26)
                    .foregroundColor(selected == value ? Color.appBackgroundColor: .white)
                
                Text(value)
                    .font(.caption)
                    .foregroundColor(selected == value ? Color.appBackgroundColor: .white)
                    .opacity(selected == value ? 1 : 0)
                
            }
        })
        .frame(width: 70, height: 50)
        .padding(.top)
        .offset(y: selected == value ? -15 : 0)
        
    }
}
