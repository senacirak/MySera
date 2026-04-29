//
//  HomeViewModel.swift
//  MySera
//
//  Created by Sena Çırak on 13.04.2026.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var waterConsumed: Int = 0
    @Published var waterGoal: Int = 8
    @Published var dailyAffirmation: String = "Nefes al, buradasın ve güvendesin."
    
    private var lastLoadedDayKey: String?
    
    init() {
        loadDailyAffirmationIfNeeded()
    }
    
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<12: return "Good Morning ☀️"
        case 12..<18: return "Good Afternoon 🌿"
        case 18..<22: return "Good Evening 🌙"
        default: return "Good Night 🌚"
        }
    }
    
    func loadDailyAffirmationIfNeeded() {
        let todayKey = Self.dayKey(for: Date())
        guard lastLoadedDayKey != todayKey else { return }
        
        let items = AffirmationLoader.load()
        guard !items.isEmpty else { return }
        
        let seed = Int(todayKey) ?? (Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1)
        let index = abs(seed) % items.count
        
        dailyAffirmation = items[index].text
        lastLoadedDayKey = todayKey
    }
    
    private static func dayKey(for date: Date) -> String {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let year = components.year ?? 0
        let month = components.month ?? 0
        let day = components.day ?? 0
        return "\(year)\(String(format: "%02d", month))\(String(format: "%02d", day))"
    }

}
