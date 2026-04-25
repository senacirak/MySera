//
//  NoteCardView.swift
//  MySera
//
//  Created by Sena Çırak on 15.04.2026.
//

import SwiftUI

struct NoteCardView: View {
    
    var note: Note
 
    var body: some View {
        VStack(alignment: .leading,spacing: 12) {
            
            HStack{
                //duygu etiketi
                Text(note.emotion.rawValue)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.black.opacity(0.72))
                    .padding(.horizontal, 8)
                    .padding(.vertical,4)
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(8)
                
                Spacer()
                
                //tarih
                Text(note.formattedDate)
                    .font(.caption2)
                    .foregroundStyle(.black.opacity(0.4))
            }
            
            //not içeriği
            Text(note.content)
                .font(.subheadline)
                .foregroundStyle(Color.black.opacity(0.8))
                .lineLimit(4) //sadece ilk 4 satırı gösterir
                .multilineTextAlignment(.leading)
            
            Spacer(minLength: 0)
            
        }
        .padding(16)
        .frame(minHeight: 120,maxHeight: 180, alignment: .topLeading)
        .background(note.emotion.color)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0 ,y: 5)
    }
}

#Preview {
    NoteCardView(note: Note(content: "hejgnvsjdnvsdnbjfs skgnsd skjgnvs skjnvs ksngvskj sjkvns skvnskjnvs skjsj skjgnss fskgnskg skg sskvs ksvsdbvjsdfbnsdf sjfbnd gjgs gjgndsg ejg sjgs gej sjsg sjg sgnwergfs bdfhbdbdgh rbgbr  rb bveb  yy", emotion: .tired))
        .padding()
}
