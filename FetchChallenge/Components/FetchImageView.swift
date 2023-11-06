//
//  FetchImageView.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import SwiftUI

struct FetchImageView: View {
    let imageUrl: URL
    
    var body: some View {
        AsyncImage(url: imageUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Rectangle()
                .foregroundStyle(.black.opacity(0.2))
                .redacted(reason: .placeholder)
        }
    }
}

#Preview {
    FetchImageView(imageUrl: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")!)
}
