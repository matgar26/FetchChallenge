//
//  MealItem.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import Foundation

struct MealItem: Decodable, Identifiable {
    
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    var id: String {
        idMeal
    }
}

extension MealItem {
    static var testData: [MealItem] = {
        var items = [MealItem]()
        items.append(MealItem(idMeal: "53049", strMeal: "Apam balik", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
        
        for x in 1...20 {
            items.append(MealItem(idMeal: "\(x)", strMeal: "Test Meal Name \(x)", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
        }
        
        return items
    }()
}
