//
//  MealsListViewModel.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import SwiftUI

@Observable class MealsListViewModel {
    let cattegory = "Dessert"
    var meals: [MealItem] = []

    func fetchMeals() async {
        let request = GetMealsRequest(cattegory: cattegory)
        do {
            let response = try await request.sendRequest()
            meals = response.meals.sorted(by: { $0.strMeal < $1.strMeal })
        } catch {
            print("Failed to fetch meal details: \(error)")
        }
    }
}
