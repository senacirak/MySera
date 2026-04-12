//
//  Item.swift
//  MySera
//
//  Created by Sena Çırak on 7.04.2026.
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
