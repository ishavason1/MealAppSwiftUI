//
//  AuthenticationType.swift
//  MealApp
//
//  Created by Isha on 02/05/21.
//  Copyright © 2021 Isha. All rights reserved.
//

import Foundation
enum AuthenticationType: String {
    case login
    case signup

    var text: String {
        rawValue.capitalized
    }

    var assetBackgroundName: String {
        self == .login ? "login" : "signup"
    }

    var footerText: String {
        switch self {
            case .login:
                return "Not a member? SIGNUP"

            case .signup:
                return "Already a member? LOGIN"
        }
    }
}

extension NSError: Identifiable {
    public var id: Int { code }
}
