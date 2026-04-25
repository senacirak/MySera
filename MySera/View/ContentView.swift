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
        ZStack {
            AppTheme.background.ignoresSafeArea()
            
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                
                NefesView()
                    .tabItem {
                        Label("Breath", systemImage: "wind")
                    }
                    .tag(1)
                
                NotesView()
                    .tabItem {
                        Label("Notes", systemImage: "pencil")
                    }
                    .tag(2)
            }
        }
        .tint(.purple)
    }
}

#Preview {
    ContentView()
}
