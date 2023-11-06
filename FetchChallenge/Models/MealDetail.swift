//
//  MealDetail.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import Foundation

struct MealDetail: Codable {
    var idMeal: String
    var strMeal: String
    var strInstructions: String
    var ingredientDict: [String: String] = [:]
    
    var sortedIngredientKeys: [String]


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AnyCodingKey.self)

        // Decode the standard properties
        idMeal = try container.decode(String.self, forKey: AnyCodingKey(stringValue: "idMeal")!)
        strMeal = try container.decode(String.self, forKey: AnyCodingKey(stringValue: "strMeal")!)
        strInstructions = try container.decode(String.self, forKey: AnyCodingKey(stringValue: "strInstructions")!)

        // Decode ingredients and measurements into their respective dictionaries
        for i in 1...20 {
            if let ingredient = try container.decodeIfPresent(String.self, forKey: AnyCodingKey(stringValue: "strIngredient\(i)")!),
               !ingredient.isEmpty,
               let measure = try container.decodeIfPresent(String.self, forKey: AnyCodingKey(stringValue: "strMeasure\(i)")!),
               !measure.isEmpty
            {
                ingredientDict[ingredient] = measure
            }
        }
        
        self.sortedIngredientKeys = ingredientDict.keys.sorted()
    }
}

// Custom CodingKey to allow dynamic keys
private struct AnyCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }

    init?(intValue: Int) {
        return nil // We don't use this, just fulfill the protocol requirements
    }
}
