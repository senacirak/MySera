//
//  ContentView.swift
//  MySera
//
//  Created by Sena Çırak on 7.04.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            NefesView()
                .tabItem {
                    Label("Nefes", systemImage: "airplayaudio")
                }
                .tag(1)
        }
        .tint(.purple)
    }
}

#Preview {
    ContentView()
}
