//
//  HelperFile.swift
//  MealApp
//
//  Created by Isha on 08/09/20.
//  Copyright © 2020 Isha. All rights reserved.
//

import Foundation
import SwiftUI
class ImageLoader: ObservableObject {
    @Published var data:Data?

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}



extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
    
    static var appBackgroundColor: Color {
        return Color.init(red: 241.0/255.0, green: 156.0/255.0, blue: 187.0/255.0)
    }
}
