//
//  Affirmations.swift
//  MySera
//
//  Created by Sena Çırak on 25.04.2026.
//

import Foundation

struct Affirmation: Codable,Identifiable{
    let id: Int
    let text: String
    let category: AffirmationCategory
}

class AffirmationLoader {
    static func load() -> [Affirmation] {
        guard let url = Bundle.main.url(forResource: "Affirmations", withExtension: "json"),
        let data = try? Data(contentsOf: url)
        else {
            return []
        }
        
        let decoder = JSONDecoder()
        return (try? decoder.decode([Affirmation].self, from: data)) ?? []
    }
}

extension Array where Element == Affirmation {
    func random(for slot: NotificationSlot, excluding usedIDs: Set<Int> ) -> Affirmation? {
        let filteredByCategory = self.filter { slot.preferredCategories.contains($0.category) }
        let withoutUsed = filteredByCategory.filter { !usedIDs.contains($0.id) }
        if let pick = withoutUsed.randomElement() {
            return pick
        }
        // Tükendiyse kategoride tekrar başlat
        return filteredByCategory.randomElement()
    }
}
