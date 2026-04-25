//
//  AddNotesView.swift
//  MySera
//
//  Created by Sena Çırak on 17.04.2026.
//

import SwiftUI
import SwiftData

struct AddNotesView: View {
    
    @State private var noteText = "" //kullanıcının yazdığı metin
    @State private var selectedEmotion: NoteEmotion = .peaceful //seçilen duygu
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    private var canSave: Bool {
            !noteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            
            VStack(alignment: .leading,spacing: 15) {
                
            //BAŞLIK SATIRI
            HStack {
                Text("New Note")
                    .font(.system(size: 22,weight: .bold,design: .rounded))
                Spacer()
                
            }
            
            // DUYGU SEÇİMİ
            VStack{
                Text("How do you feel?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                //duygular
                     
            }
            
            // YAZI ALANI
            ZStack(alignment: .topLeading){
                if noteText.isEmpty{
                    Text("What were your thoughts and feelings today?")
                        .foregroundStyle(.secondary.opacity(0.6))
                        .padding(.top,8)
                        .padding(.leading,4)
                }
                TextEditor(text: $noteText)
                    .frame(minHeight: 150)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
            }
            .padding(12)
            .background(Color.primary.opacity(0.04)) // Çok hafif gri arka plan
            .cornerRadius(12)
            
            // KAYDET BUTONU
            Button{
                guard canSave else { return }
                let note = Note(
                    content:  noteText.trimmingCharacters(in: .whitespacesAndNewlines), emotion: selectedEmotion
                )
                modelContext.insert(note)
                dismiss() //paneli kapat
            }label: {
                Text("Save")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(canSave ? Color.green : Color.gray.opacity(0.5))
                    .cornerRadius(14)
            }
            .disabled(!canSave)
            Spacer()
        }
        .padding(24)
        }
    }
}

#Preview {
    AddNotesView()
        .modelContainer(for: [Note.self, Item.self], inMemory: true)
}
