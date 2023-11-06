//
//  GetMealsRequest.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import Foundation

struct GetMealsRequest: ApiRequestGet {
    typealias Response = MealsResponse
    
    let cattegory: String
    init(cattegory: String) {
        self.cattegory = cattegory
    }

    var path: String = "/filter.php"
    var queryItems: [String : String] {
        ["c" : self.cattegory]
    }
}

struct MealsResponse: Decodable {
    let meals: [MealItem]
}
