//
//  Meals.swift
//  MealApp
//
//  Created by Isha on 12/09/20.
//  Copyright © 2020 Isha. All rights reserved.
//

import Foundation
struct Meals: Codable {
    var meals: [MealList]?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.meals = try values.decodeIfPresent([MealList].self, forKey: .meals)
    }
}

struct MealList: Codable, Hashable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
}
