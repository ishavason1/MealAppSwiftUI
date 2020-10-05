//
//  CategoryFoodListViewModel.swift
//  MealApp
//
//  Created by Isha on 04/10/20.
//  Copyright © 2020 Isha. All rights reserved.
//

import Foundation
import SwiftUI
 class CategoryFoodListViewModel: ObservableObject {
    @Published private(set) var categoriesMealData: [MealList] = []
    func loadList(title: String) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(title)") else {
            print("Invalid URL")
            return
        }
        print(url)
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Meals.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.categoriesMealData = decodedResponse.meals ?? []
                    }
                    // everything is good, so we can exit
                    return
                }
            }
        }.resume()
    }
}
