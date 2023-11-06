//
//  MealItemRow.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import SwiftUI

struct MealItemRow: View {
    var mealItem: MealItem

    var body: some View {
        HStack(spacing: 10) {
            if let imageUrl = URL(string: mealItem.strMealThumb) {
                FetchImageView(imageUrl: imageUrl)
                    .frame(width: 60, height: 60) // Adjust size as desired
                    .clipShape(.circle)
            }

            Text(mealItem.strMeal)
                .font(.headline)
        }
    }
}

#Preview {
    MealItemRow(mealItem: MealItem.testData.first!)
}
