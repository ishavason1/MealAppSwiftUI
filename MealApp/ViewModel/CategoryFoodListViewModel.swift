//
//  CategoryFoodListViewModel.swift
//  MealApp
//
//  Created by Isha on 04/10/20.
//  Copyright © 2020 Isha. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

 class CategoryFoodListViewModel: ObservableObject {
    @Published private(set) var categoriesMealData: [MealList] = []
    var cancellationToken: AnyCancellable?
    func getFoodList(title: String)  {
        cancellationToken = self.makeRequestForCategory(categoryTitle: title)
            .mapError({(error) -> Error in
                print(error)
                return error
            })
        .sink(receiveCompletion: { _ in }, receiveValue: { response in
            self.categoriesMealData = response.meals ?? []
        })
    }
    
    func makeRequestForCategory(categoryTitle: String) -> AnyPublisher<Meals, Error> {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(categoryTitle)") else {
            fatalError("Invalid URL")
        }
        let request = URLRequest(url: url)
        return APIClient().run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}





