//
//  GetMealDetailsRequest.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import Foundation

struct GetMealDetailsRequest: ApiRequestGet {
    typealias Response = MealDetailResponse
    
    let mealId: String
    
    init(mealId: String) {
        self.mealId = mealId
    }

    var path: String = "/lookup.php"
    var queryItems: [String : String] {
        ["i" : mealId]
    }
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}
