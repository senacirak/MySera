//
//  HomeView.swift
//  MySera
//
//  Created by Sena Çırak on 7.04.2026.
//

import SwiftUI

struct HomeView: View {
    
    // ViewModel Bağlantısı (İçinde data ve fonksiyonlarımız var)
    @StateObject private var viewModel = HomeViewModel()
    
    let titleColor = Color.black.opacity(0.82)
    
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 25) {
                    
                    // Başlık ve Olumlama Alanı
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.greeting)
                            .font(.system(size: 32, weight: .semibold, design: .rounded))
                            .foregroundColor(titleColor)
                        
//                        Text(viewModel.affirmation)
//                            .font(.system(size: 16, weight: .regular, design: .serif))
//                            .italic()
//                            .foregroundColor(Color.primary.opacity(0.6))
//                            .lineSpacing(4)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    
                    DailyAffirmationCard(text: viewModel.dailyAffirmation)
                        .padding(.horizontal, 20)
                    
                    // Su Takibi Kartı ($viewModel kullanarak bind ediyoruz)
                    WaterTrackerCard(waterConsumed: $viewModel.waterConsumed, waterGoal: viewModel.waterGoal)
                        .padding(.horizontal, 20)
                    
                    // Görevler / Alışkanlıklar (Gelecekte Dinamik Olacak)
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Today's Intentions")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .foregroundColor(titleColor)
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 12) {
                            HabitRow(icon: "figure.mind.and.body", title: "Face Yoga", completed: false)
                            HabitRow(icon: "pills", title: "Magnesium & Omega 3", completed: true)
                            HabitRow(icon: "moon.zzz", title: "Early Sleep", completed: false)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 10)
                    
                    Spacer(minLength: 40)
                }
            }
        }
    }
}

// MARK: - Alt Bileşenler (Subviews)

struct WaterTrackerCard: View {
    @Binding var waterConsumed: Int
    var waterGoal: Int
    
    var progress: CGFloat {
        if waterGoal == 0 { return 0 }
        return CGFloat(waterConsumed) / CGFloat(waterGoal)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Hydration")
                    .font(.headline)
                    .foregroundColor(Color.primary.opacity(0.8))
                
                Text("\(waterConsumed) / \(waterGoal) Glasses")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Dairesel Progress + Ekleme Butonu
            ZStack {
                // Background Circle
                Circle()
                    .stroke(Color.blue.opacity(0.15), lineWidth: 6)
                    .frame(width: 50, height: 50)
                
                // Progress Circle
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.blue.opacity(0.6), style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(-90))
                    .animation(.spring(), value: waterConsumed)
                
                Button(action: {
                    if waterConsumed < waterGoal {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        waterConsumed += 1
                    }
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.blue.opacity(0.8))
                }
            }
        }
        .padding(20)
        .background(Color.white.opacity(0.7))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 5)
    }
}

struct DailyAffirmationCard: View {
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Gunun Sozu")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.secondary)
            
            Text("\"\(text)\"")
                .font(.custom("Georgia", size: 19))
                .italic()
                .lineSpacing(6)
                .foregroundStyle(.primary.opacity(0.9))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.white.opacity(0.25), lineWidth: 1)
        )
    }
}

struct HabitRow: View {
    var icon: String
    var title: String
    var completed: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(completed ? .green : .gray)
                .frame(width: 30)
            
            Text(title)
                .font(.body)
                .foregroundColor(completed ? .gray : .primary.opacity(0.8))
                .strikethrough(completed, color: .gray)
            
            Spacer()
            
            // Tik Kutusu
            Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 22, weight: .light))
                .foregroundColor(completed ? .green : .gray.opacity(0.5))
        }
        .padding(16)
        .background(Color.white.opacity(0.6))
        .cornerRadius(16)
    }
}

#Preview {
    HomeView()
}
