//
//  MealDetailView.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import SwiftUI

struct MealDetailView: View {
    @State private var viewModel: MealDetailViewModel
    
    init(mealItem: MealItem) {
        self.viewModel = MealDetailViewModel(mealItem: mealItem)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                
                if let imageUrl = URL(string: viewModel.mealItem.strMealThumb) {
                    FetchImageView(imageUrl: imageUrl)
                        .frame(maxWidth: .infinity)
                }
                
                VStack(alignment: .leading, spacing: 16) {
        
                    Text("Ingredients:")
                        .font(.title)
                    
                    if viewModel.mealDetail == nil {
                        ForEach(1...10, id: \.self) { index in
                            Text(RedactedPlaceholderHelpers.title)
                                .redacted(reason: .placeholder)
                        }
                    } else {
                        ForEach(viewModel.mealDetail?.sortedIngredientKeys ?? [], id: \.self) { key in
                            if let value = viewModel.mealDetail?.ingredientDict[key] {
                                Text("• \(key): **\(value)**")
                            }
                        }
                    }
                    
                    Text("Instructions:")
                        .font(.title)
                    
                    Text(viewModel.mealDetail?.strInstructions ?? RedactedPlaceholderHelpers.paragraph)
                        .redacted(reason: viewModel.mealDetail == nil ? .placeholder : [])
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.mealItem.strMeal)
        .task {
            await viewModel.fetchMealDetail()
        }
        .refreshable {
            await viewModel.fetchMealDetail()
        }
    }
}

#Preview {
    NavigationView {
        MealDetailView(mealItem: MealItem.testData.first!)
    }
}
