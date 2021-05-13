//
//  SignUpView.swift
//  MealApp
//
//  Created by Isha on 29/04/21.
//  Copyright © 2021 Isha. All rights reserved.
//

import SwiftUI
let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
struct SignUpView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""
    init(){
          UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
      }
      
    var body: some View {
        ZStack {
            Color.appBackgroundColor.edgesIgnoringSafeArea(.all)
                    VStack() {
                        WelcomeText()
                        UserImage()
                        
                        TextField("Name", text: $username)
                                        .padding()
                            .background(lightGreyColor)
                                        .cornerRadius(5.0)
                                        .padding(.bottom, 20)
                        TextField("Email", text: $email)
                                        .padding()
                            .background(lightGreyColor)
                                        .cornerRadius(5.0)
                                        .padding(.bottom, 20)
                        TextField("Password", text: $password)
                                        .padding()
                            .background(lightGreyColor)
                                        .cornerRadius(5.0)
                                        .padding(.bottom, 40)
                        SignupButtonContent()
                        
                    }.padding()
                    
                    .background(Color.appBackgroundColor)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

struct WelcomeText : View {
    var body: some View {
        return Text("Welcome!")
            .font(.largeTitle)
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct UserImage : View {
    var body: some View {
        return Image("dineImage")
            
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 20)
            
           
            
    }
}

struct SignupButtonContent : View {
    var body: some View {
        return Text("Signup")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.appButtonColor)
            .cornerRadius(15.0)
    }
}
