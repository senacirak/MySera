//
//  NotesView.swift
//  MySera
//
//  Created by Sena Çırak on 15.04.2026.
//

import SwiftUI
import SwiftData

struct NotesView: View {
    @Query(sort: \Note.date, order: .reverse) private var notes: [Note]
    
    //not ekleme sayfasının açılıp açılmayacağını kontrol eden anahtar
    @State private var showAddNote = false
    
    //MANTIK 1: pinterest görünümü için elimizdeki notların yarısını sol sütüna ayırıyoruz
    var leftColumnNotes: [Note] {
        notes.enumerated().filter { $0.offset % 2 == 0 }.map { $0.element }
    }
    
    //MANTIK 2: geri kalan yarısını da sağ sütuna ayırıyoruz
    var rightColumnNotes: [Note] {
        notes.enumerated().filter { $0.offset % 2 != 0 }.map { $0.element }
    }
    
    let titleColor = Color.black.opacity(0.82)
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing){
                AppTheme.background.ignoresSafeArea()
                
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading,spacing: 15) {
                        // başlık ve alt yazı
                        Text("Notes")
                            .font(.system(size: 32, weight: .semibold, design: .rounded))
                            .foregroundColor(titleColor)
                        Text("How are you feeling today?")
                            .font(.subheadline)
                            .foregroundColor(titleColor)
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    
                    // IZGARA
                    HStack(alignment: .top, spacing: 16) {
                        //sol taraftaki notlar
                        VStack(spacing:16){
                            ForEach(leftColumnNotes) { note in
                                NavigationLink {
                                    NoteDetailView()
                                }label: {
                                    NoteCardView(note: note)
                                }
                                .buttonStyle(.plain)
                                .contextMenu { Button(role:.destructive) {
                                            modelContext.delete(note)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                }
                            }
                        }
                        
                        //sağ taraftaki notlar
                        VStack(spacing:16){
                            ForEach(rightColumnNotes) { note in
                                NavigationLink {
                                    NoteDetailView()
                                }label: {
                                    NoteCardView(note: note)
                                }
                                .buttonStyle(.plain)
                                .contextMenu { Button(role:.destructive) {
                                            modelContext.delete(note)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom,80)
                }
                //EKLE butonu
                Button {
                    showAddNote = true
                } label: {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.78, green: 0.67, blue: 0.88),
                                        Color(red: 0.64, green: 0.54, blue: 0.79)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 62, height: 62)
                        
                        Circle()
                            .stroke(Color.white.opacity(0.55), lineWidth: 1.4)
                            .frame(width: 62, height: 62)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .shadow(color: Color.black.opacity(0.16), radius: 14, x: 0, y: 8)
                    .shadow(color: Color(red: 0.64, green: 0.54, blue: 0.79).opacity(0.30), radius: 10, x: 0, y: 4)
                }
                .padding()
                .navigationDestination(isPresented: $showAddNote){
                    AddNotesView()
                }
            }
        }
    }
}

#Preview {
    NotesView()
}
