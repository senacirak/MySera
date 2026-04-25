//
//  NotesModel.swift
//  MySera
//
//  Created by Sena Çırak on 15.04.2026.
//

import SwiftUI
import Foundation
import SwiftData

// duygular ve onlara karşılık gelen renkler
enum NoteEmotion: String,CaseIterable,Codable{
    case peaceful = "Peaceful"
    case happy = "Happy"
    case tired = "Tired"
    case stressed = "Stressed"

    var color: Color {
        switch self {
        case .peaceful: return Color(red: 0.89, green: 0.93, blue: 0.91) // soft sage
        case .happy: return Color(red: 0.98, green: 0.92, blue: 0.86)    // pastel peach
        case .tired: return Color(red: 0.88, green: 0.90, blue: 0.96)    // misty blue
        case .stressed: return Color(red: 0.93, green: 0.88, blue: 0.92) // dusty lilac
        }
    }
}

// bir notu sahip olabileceği özellikler
@Model
final class Note {
    var content: String // içeriği var
    var emotion: NoteEmotion // duygusu var (rengi belirleyecek)
    var date: Date  // oluşturulma tarihi
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: date)
    }
    
    init(content: String, emotion: NoteEmotion, date: Date = Date()) {
           self.content = content
           self.emotion = emotion
           self.date = date
       }
}

