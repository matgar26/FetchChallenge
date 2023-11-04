//
//  Item.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
