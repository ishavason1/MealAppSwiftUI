//
//  CategoryViewModel.swift
//  MealApp
//
//  Created by Isha on 04/10/20.
//  Copyright © 2020 Isha. All rights reserved.
//

import Foundation
import SwiftUI
final class CategoryListViewModel: ObservableObject {
    init() {
        
    }
    @Published private(set) var categoriesData: [Categories] = []
    func loadData() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
           if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.categoriesData = decodedResponse.categories ?? []
                    }
                    // everything is good, so we can exit
                    return
                }
            }
        }.resume()
    }
}
