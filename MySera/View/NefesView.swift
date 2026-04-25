//
//  NefesView.swift
//  MySera
//
//  Created by Sena Çırak on 7.04.2026.
//

import SwiftUI

struct NefesView: View {
    enum BreathePhase {
        case idle, inhale, hold, exhale
        
        var label: String {
            switch self {
            case .idle: return "Press to start"
            case .inhale: return "Breathe"
            case .hold: return "Hold"
            case .exhale: return "Exhale"
            }
        }
        
        var duration: Double {
            switch self {
            case .idle: return 0
            case .inhale: return 4
            case .hold: return 7
            case .exhale: return 8
            }
        }
        
        var scale: CGFloat {
            switch self {
            case .idle , .exhale: return 0.6
            case .inhale, .hold: return 1.0
            }
        }
        
        var color: Color {
            switch self {
            case .idle: return Color(red: 0.75, green: 0.70, blue: 0.85)
            case .inhale: return Color(red: 0.72, green: 0.80, blue: 0.90)
            case .hold: return Color(red: 0.85, green: 0.75, blue: 0.90)
            case .exhale: return Color(red: 0.90, green: 0.75, blue: 0.85)
            }
        }
    }
    
    // Parçacık açıları — 8 yön
    let angles: [Double] = [0, 45, 90, 135, 180, 225, 270, 315]
    
    @State private var phase: BreathePhase = .idle
    @State private var scale: CGFloat = 0.6
    @State private var countdown: Int = 0
    @State private var timer: Timer? = nil
    @State private var cycleCount: Int = 0
    
    // Tamamlanma
    @State private var showParticles: Bool = false
    @State private var particleOffset: CGFloat = 0
    @State private var particleOpacity: Double = 0
    @State private var showCompletion: Bool = false
    
    var body: some View {
        ZStack {
            // Arka plan
            LinearGradient(
                colors: [
                    Color(red: 0.96, green: 0.90, blue: 0.96),
                    Color(red: 0.85, green: 0.80, blue: 0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Ana nefes ekranı
            VStack {
                Text("4 - 7 - 8 Breathing")
                    .font(.system(size: 30, weight: .medium, design: .rounded))
                    .foregroundStyle(Color(red: 0.55, green: 0.40, blue: 0.65))
                    .padding(.top, 60)
                
                Spacer()
                
                VStack(spacing: 35) {
                    // Tur sayısı
                    Text("Tour: \(cycleCount) / 4")
                        .foregroundStyle(Color(red: 0.55, green: 0.45, blue: 0.65))
                        .font(.system(size: 17, weight: .regular))
                        .opacity(phase != .idle ? 1 : 0)
                    
                    // Daire + Parçacıklar
                    ZStack {
                        // Ana daire
                        Circle()
                            .fill(phase.color.opacity(0.5))
                            .frame(width: 200, height: 200)
                            .scaleEffect(scale)
                            .animation(.easeInOut(duration: phase.duration > 0 ? phase.duration : 0.5), value: scale)
                            .animation(.easeInOut(duration: 0.5), value: phase.color)
                            .opacity(showCompletion ? 0 : 1)
                        
                        // Yazılar
                        VStack {
                            Text("\(countdown)")
                                .font(.system(size: 50, weight: .light))
                                .foregroundStyle(Color(red: 0.3, green: 0.2, blue: 0.4))
                            Text(phase.label)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(Color(red: 0.45, green: 0.35, blue: 0.55))
                        }
                        .opacity(showCompletion ? 0 : 1)
                        .onTapGesture {
                            if phase == .idle { startBreathing() }
                        }
                        
                        // Parçacıklar
                        if showParticles {
                            ForEach(angles, id: \.self) { angle in
                                Circle()
                                    .fill(Color(red: 0.80, green: 0.65, blue: 0.90))
                                    .frame(width: 10, height: 10)
                                    .offset(
                                        x: cos(angle * .pi / 180) * particleOffset,
                                        y: sin(angle * .pi / 180) * particleOffset
                                    )
                                    .opacity(particleOpacity)
                            }
                        }
                        
                        // Tebrik ekranı
                        if showCompletion {
                            VStack(spacing: 16) {
                                Text("🌸")
                                    .font(.system(size: 60))
                                Text("Well done!")
                                    .font(.system(size: 32, weight: .light, design: .rounded))
                                    .foregroundStyle(Color(red: 0.55, green: 0.40, blue: 0.65))
                                Text("You completed 4 rounds.")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundStyle(Color(red: 0.55, green: 0.45, blue: 0.65).opacity(0.7))
                                
                                Button {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        showCompletion = false
                                        showParticles = false
                                        cycleCount = 0
                                    }
                                } label: {
                                    Text("Try Again")
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 28)
                                        .padding(.vertical, 10)
                                        .background(Color(red: 0.70, green: 0.55, blue: 0.85))
                                        .clipShape(Capsule())
                                }
                            }
                            .transition(.opacity.combined(with: .scale(scale: 0.85)))
                        }
                    }
                    
                    // Stop butonu
                    Button {
                        stopBreathing()
                    } label: {
                        Text("Stop")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 10)
                            .background(Color(red: 0.55, green: 0.45, blue: 0.65).opacity(0.5))
                            .clipShape(Capsule())
                    }
                    .opacity(phase != .idle && !showCompletion ? 1 : 0)
                }
                
                Spacer()
            }
        }
    }
    
    // MARK: - Fonksiyonlar
    
    func startBreathing() {
        cycleCount = 0
        startPhase(.inhale)
    }
    
    func startPhase(_ newPhase: BreathePhase) {
        phase = newPhase
        scale = newPhase.scale
        countdown = Int(newPhase.duration)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            DispatchQueue.main.async {
                if countdown > 1 {
                    countdown -= 1
                } else {
                    timer.invalidate()
                    switch phase {
                    case .inhale: startPhase(.hold)
                    case .hold:   startPhase(.exhale)
                    case .exhale:
                        cycleCount += 1
                        if cycleCount >= 4 {
                            stopBreathing()
                            triggerCompletion()
                        } else {
                            startPhase(.inhale)
                        }
                    case .idle: break
                    }
                }
            }
        }
    }
    
    func stopBreathing() {
        timer?.invalidate()
        timer = nil
        phase = .idle
        scale = 0.6
        countdown = 0
    }
    
    func triggerCompletion() {
        // Parçacıkları ekrana çiz
        showParticles = true
        particleOffset = 0
        particleOpacity = 1
        
        // Küçük bir bekleme: SwiftUI parçacıkları render etsin, sonra animasyonu başlat
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            withAnimation(.easeOut(duration: 0.7)) {
                particleOffset = 140
                particleOpacity = 0
            }
        }
        
        // 0.6sn sonra tebrik yazısını göster
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.spring(duration: 0.5)) {
                showCompletion = true
            }
        }
    }
}

#Preview {
    NefesView()
}
