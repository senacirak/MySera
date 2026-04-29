//
//  NotificationFrequency.swift
//  MySera
//
//  Created by Sena Çırak on 26.04.2026.
//

import Foundation

enum NotificationFrequency: String,CaseIterable, Codable{
    case threePerDay
    case fourPerDay
    case fivePerDay
    
    var title: String {
        switch self {
        case .threePerDay:
            return "3 per day"
        case .fourPerDay:
            return "4 per day"
        case .fivePerDay:
            return "5 per day"
        }
    }
    
    var slots: [NotificationSlot] {
        switch self {
        case .threePerDay: return [.sabah, .ogle, .aksam]
        case .fourPerDay: return [.sabah,.ogle,.ikindi,.aksam]
        case .fivePerDay: return [.sabah,.ogle,.ikindi,.aksam,.gece]
        }
    }
}
