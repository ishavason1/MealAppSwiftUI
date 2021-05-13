//
//  AuthenticationState.swift
//  MealApp
//
//  Created by Isha on 02/05/21.
//  Copyright © 2021 Isha. All rights reserved.
//

import Foundation

import Combine
import AuthenticationServices
import FirebaseAuth

enum LoginOption {
    case signInWithApple
    case emailAndPassword(email: String, password: String)
}

class AuthenticationState: NSObject, ObservableObject {

    @Published var loggedInUser: User?
    @Published var isAuthenticating = false
    @Published var error: NSError?
    var handle: AuthStateDidChangeListenerHandle?

    static let shared = AuthenticationState()

    private let auth = Auth.auth()
    fileprivate var currentNonce: String?

    func login(with loginOption: LoginOption) {
        self.isAuthenticating = true
        self.error = nil

        switch loginOption {
            case let .emailAndPassword(email, password):
                handleSignInWith(email: email, password: password)
        case .signInWithApple:
            break
        }
    }

    func signup(email: String, password: String, passwordConfirmation: String) {
        guard password == passwordConfirmation else {
            self.error = NSError(domain: "", code: 9210, userInfo: [NSLocalizedDescriptionKey: "Password and confirmation does not match"])
            return
        }
        
        self.isAuthenticating = true
        self.error = nil
        
        auth.createUser(withEmail: email, password: password, completion: handleAuthResultCompletion)
    }

    private func handleSignInWith(email: String, password: String) {
        auth.signIn(withEmail: email, password: password, completion: handleAuthResultCompletion)
    }

    private func handleAuthResultCompletion(auth: AuthDataResult?, error: Error?) {
        DispatchQueue.main.async {
            self.isAuthenticating = false
            if let user = auth?.user {
                self.loggedInUser = user
            } else if let error = error {
                self.error = error as NSError
            }
        }
    }
    
    func listen () {
           // monitor authentication changes using firebase
           handle = Auth.auth().addStateDidChangeListener { (auth, user) in
               if let user = user {
                   // if we have a user, create a new user model
                   print("Got user: \(user)")
                self.loggedInUser = user
               } else {
                   // if we don't have a user, set our session to nil
                   self.loggedInUser = nil
               }
           }
       }
}
