//
//  HomeViewModel.swift
//  MySera
//
//  Created by Sena Çırak on 13.04.2026.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var waterConsumed: Int = 0
    @Published var waterGoal: Int = 8
    
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<12: return "Good Morning ☀️"
        case 12..<18: return "Good Afternoon 🌿"
        case 18..<22: return "Good Evening 🌙"
        default: return "Good Night 🌚"
        }
    }
    

}
