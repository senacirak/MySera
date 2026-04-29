//
//  NotificationSlot.swift
//  MySera
//
//  Created by Sena Çırak on 26.04.2026.
//

import Foundation

enum NotificationSlot: CaseIterable {
    case sabah
    case ogle
    case ikindi
    case aksam
    case gece
    
    var hour: Int {
        switch self {
        case .sabah: return 9
        case .ogle: return 13
        case .ikindi: return 16
        case .aksam: return 20
        case .gece: return 23
        }
    }
    
    var minute: Int {
        switch self {
        case .sabah, .ogle, .gece: return 0
        case .ikindi, .aksam : return 30
        }
    }
    
    var preferredCategories: [AffirmationCategory] {
        switch self {
        case .sabah: return [.guc, .an]
        case .ogle: return [.stres, .farkindalik]
        case .ikindi: return [.ozSefkat, .anksiyete]
        case .aksam: return [.huzur]
        case .gece: return [.uyku, .huzur]
        }
    }
    
}
