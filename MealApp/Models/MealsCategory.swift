//
//  MealsCategory.swift
//  MealApp
//
//  Created by Isha on 06/09/20.
//  Copyright © 2020 Isha. All rights reserved.
//

import Foundation
struct Response: Codable {
    var categories: [Categories]?
    
    enum CodingKeys: String, CodingKey {
        case categories
      
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
    }
}

struct Categories: Hashable, Codable {
    let idCategory : String
    let strCategory : String
    let strCategoryThumb : String
}

