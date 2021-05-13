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
        return Color.init(red: 38.0/255.0, green: 79.0/255.0, blue: 82.0/255.0)
    }
    
    static var appButtonColor: Color {
        return Color.init(red: 136.0/255.0, green: 189.0/255.0, blue: 179.0/255.0)
    }
}

struct ProgressView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<ProgressView>) -> UIActivityIndicatorView {
        let indicator =  UIActivityIndicatorView(style: .large)
        indicator.color = UIColor.white
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ProgressView>) {
        uiView.startAnimating()
    }
}

struct XCAButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(width: 130, height: 44)
            .foregroundColor(Color.white)
            .background(Color.appButtonColor)
            .cornerRadius(8)
    }
}



