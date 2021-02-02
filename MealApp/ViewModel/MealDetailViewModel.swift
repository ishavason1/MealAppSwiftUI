//
//  MealDetailViewModel.swift
//  MealApp
//
//  Created by Isha on 28/01/21.
//  Copyright © 2021 Isha. All rights reserved.
//

import Foundation
import Combine
class MealDetailViewModel: ObservableObject {
    @Published private(set) var mealDetailData: [MealDetail] = []
    var cancellationToken: AnyCancellable?
    
    func loadMealDetails(_ meal: String) {
        cancellationToken = self.makeRequestForMealDetail(mealId: meal)
            .mapError({(error) -> Error in
                print(error)
                return error
            })
        .sink(receiveCompletion: { _ in }, receiveValue: { response in
            self.mealDetailData = response.meals ?? []
        })
    }
    
    func makeRequestForMealDetail(mealId: String) -> AnyPublisher<MealInfo, Error> {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)") else {
            fatalError("Invalid URL")
        }
        let request = URLRequest(url: url)
        return APIClient().run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
