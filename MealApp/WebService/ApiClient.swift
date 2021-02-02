//
//  ApiClient.swift
//  MealApp
//
//  Created by Isha on 27/01/21.
//  Copyright © 2021 Isha. All rights reserved.
//

import Foundation
import Combine
struct APIClient {

    struct Response<T> { // 1
        let value: T
        let response: URLResponse
    }
    func getFoodList(title: String) -> AnyPublisher<Meals, Error> {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(title)") else {
            fatalError("Invalid URL")
        }
     return   URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
            .decode(type: Meals.self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
            
    }
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> { // 2
           return URLSession.shared
               .dataTaskPublisher(for: request) // 3
               .tryMap { result -> Response<T> in
                   let value = try JSONDecoder().decode(T.self, from: result.data) // 4
                   return Response(value: value, response: result.response) // 5
               }
               .receive(on:  RunLoop.main) // 6
               .eraseToAnyPublisher() // 7
       }
}
