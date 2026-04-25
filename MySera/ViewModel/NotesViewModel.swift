//
//  NotesViewModel.swift
//  MySera
//
//  Created by Sena Çırak on 15.04.2026.
//

import SwiftUI
import Combine
import Foundation

class NotesViewModel: ObservableObject {
    // @Published sayesinde bu listeye yeni bir not eklendiğinde ekran otomatik olarak güncellenir
    @Published var notes: [Note] = []
    
    //başta boş durmasın diye mock notlar
    init() {
        addMockNotes()
    }
    
    // yeni not ekleme fonksiyonu
    func addNote(content: String, emotion: NoteEmotion) {
        let newNote = Note(content: content,emotion: emotion)
        //yeni eklenen not en üstte gözüksün diye insert(at: 0) kullanıyoruz
        notes.insert(newNote,at: 0)
    }
    
    //not silme fonsiyonu
    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
    
    //mock  notlar
    private func addMockNotes() {
        notes.append(Note(content: "Merhaba gjknsdg sngk gwg ergw ge gsdhgsg d ", emotion: .peaceful))
        notes.append(Note(content: "Merhaba2gksd gwgwkgwkggskg ekgwkgjr wkgkgsg  kgkdg sdgkjs sdkgs ksgwgf w wkgwskf sfgkwgwfj g wfwkgwfw wkgfwbkgnwejfw kwgbwk fwkfgnkw kwfwkw kwbgıw kwbfgjw wjbnfjw ", emotion: .happy))
    }
}
