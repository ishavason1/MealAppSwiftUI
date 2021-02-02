//
//  CategoryViewModel.swift
//  MealApp
//
//  Created by Isha on 04/10/20.
//  Copyright © 2020 Isha. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
final class CategoryListViewModel: ObservableObject {
    @Published private(set) var categoriesData: [Categories] = []
    var cancellationToken: AnyCancellable?
    func loadData() {
        cancellationToken = self.makeRequestForCategoryList()
            .mapError({(error) -> Error in
                print(error)
                return error
            })
        .sink(receiveCompletion: { _ in }, receiveValue: { response in
            self.categoriesData = response.categories ?? []
        })
    }
    
    func makeRequestForCategoryList() -> AnyPublisher<Response, Error> {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else {
            fatalError("Invalid URL")
        }
        let request = URLRequest(url: url)
        return APIClient().run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
