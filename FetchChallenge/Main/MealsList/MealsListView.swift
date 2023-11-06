//
//  MealsListView.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import SwiftUI

struct MealsListView: View {
    @State private var viewModel = MealsListViewModel()
    let placeholderMeal = MealItem.testData.first!
    
    var body: some View {
        NavigationStack {
            List(viewModel.meals) { meal in
                if viewModel.meals.isEmpty {
                    ForEach(1...20, id: \.self) { index in
                        MealItemRow(mealItem: placeholderMeal)
                            .redacted(reason: .placeholder)
                    }
                }
                
                NavigationLink(destination: MealDetailView(mealItem: meal)) {
                    MealItemRow(mealItem: meal)
                }
            }
            .navigationTitle("Desserts")
            .task {
                await viewModel.fetchMeals()
            }
            .refreshable {
                await viewModel.fetchMeals()
            }
        }
    }
}

#Preview {
    MealsListView()
}
