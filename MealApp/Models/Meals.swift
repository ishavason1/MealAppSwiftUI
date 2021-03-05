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
}

struct MealList: Codable, Hashable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
}
