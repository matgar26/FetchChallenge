//
//  MealDetailViewModel.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import Foundation
import SwiftUI

@Observable class MealDetailViewModel {
    let mealItem: MealItem
    var mealDetail: MealDetail?
    
    init(mealItem: MealItem) {
        self.mealItem = mealItem
    }

    func fetchMealDetail() async {
        let request = GetMealDetailsRequest(mealId: mealItem.idMeal)
        do {
            let response = try await request.sendRequest()
            mealDetail = response.meals.first
        } catch {
            print("Failed to fetch meal details: \(error)")
        }
    }
}
