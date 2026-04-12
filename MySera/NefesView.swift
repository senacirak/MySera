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
    
    @State private var phase: BreathePhase = .idle
    @State private var scale: CGFloat = 0.6
    @State private var countdown: Int = 0
    @State private var timer: Timer? = nil
    @State private var cycleCount: Int = 0
    
    var body: some View {
        
        ZStack{
            LinearGradient(
                colors: [
                    Color(red: 0.96, green: 0.90, blue: 0.96),
                    Color(red: 0.85, green: 0.80, blue: 0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack{
                Text("4 - 7 - 8 Breathing")
                    .font(.system(size: 30, weight: .medium, design: .rounded))
                    .foregroundStyle(Color(red: 0.55, green: 0.40, blue: 0.65))
                    .padding(.top,60)
                
                Spacer()
                VStack(spacing: 35){
                // tur sayısı
                Text("Tour: \(cycleCount) / 4")
                    .foregroundStyle(Color(red: 0.55, green: 0.45, blue: 0.65))
                    .font(.system(size: 17, weight: .regular))
                    .opacity(phase != .idle ? 1 : 0)
                
                //daire
                ZStack{
                    Circle()
                        .fill(phase.color.opacity(0.5))
                        .frame(width: 200,height: 200)
                        .scaleEffect(scale)
                        .animation(.easeInOut(duration: phase.duration > 0 ? phase.duration : 0.5), value: scale)
                        .animation(.easeInOut(duration: 0.5),value: phase.color)
                    VStack{
                        Text("\(countdown)")
                            .font(.system(size: 50, weight: .light))
                            .foregroundStyle(Color(red: 0.3, green: 0.2, blue: 0.4))
                        Text(phase.label)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(Color(red: 0.45, green: 0.35, blue: 0.55))
                    }
                    .onTapGesture {
                        if phase == .idle {startBreathing()}
                    }
                }
                
                Button {
                    stopBreathing()
                } label: {
                    Text("Stop")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(.horizontal,28)
                        .padding(.vertical, 10)
                        .background(Color(red: 0.55, green: 0.45, blue: 0.65).opacity(12))
                        .clipShape(Capsule())
                }
                .opacity(phase != .idle ? 1 : 0)
            }
                Spacer()
            }
        }
    }
    
    func startBreathing(){
        cycleCount = 0
        startPhase(.inhale)
    }
    
    func startPhase(_ newPhase: BreathePhase){
        phase = newPhase
        scale = newPhase.scale
        countdown = Int(newPhase.duration)
        
      timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            DispatchQueue.main.async {
                if countdown > 1 {
                    countdown -= 1
                } else{
                    timer.invalidate()
                    switch phase {
                    case .inhale: startPhase(.hold)
                    case.hold: startPhase(.exhale)
                    case .exhale:
                        cycleCount += 1
                        if cycleCount >= 4 {
                            stopBreathing()
                        } else{
                            startPhase(.inhale)
                        }
                    case .idle: break
                    }
                }
            }
        }
    }
    
    func stopBreathing(){
        timer?.invalidate() //timer'ı durdur
        timer = nil
        phase = .idle       // başa dön
        scale = 0.6         // daireyi küçült
        countdown = 0
    }
}

#Preview {
    NefesView()
}
