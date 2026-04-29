//
//  AffirmationNotificationManager.swift
//  MySera
//
//  Created by Sena Çırak on 29.04.2026.
//

import Foundation
import UserNotifications

final class AffirmationNotificationManager {
    static let shared = AffirmationNotificationManager()
    private init() {}
    
    private let center = UNUserNotificationCenter.current()
    
    func requestPermission() async throws -> Bool {
        try await center.requestAuthorization(options: [.alert,.sound,.badge])
    }
    
    func scheduleDailyAffirmation (
        frequency: NotificationFrequency,
        quietHoursEnabled: Bool,
        quietStartHour: Int = 22,
        quietEndHour: Int = 8
    ) async throws {
        center.removePendingNotificationRequests(withIdentifiers: pendingIDsPrefix())
        
        let affirmations = AffirmationLoader.load()
        guard !affirmations.isEmpty else { return }
        var usedIDs = Set<Int>()
        
        for slot in frequency.slots {
            // Sessiz saat filtresi (opsiyonel)
            if quietHoursEnabled, isInQuietHours(hour: slot.hour, start: quietStartHour, end: quietEndHour) {
                continue
            }
            
            guard let selected = affirmations.random(for: slot, excluding: usedIDs) else { continue }
            usedIDs.insert(selected.id)
            
            let content = UNMutableNotificationContent()
            content.title = "Kendine Nazik Bir An"
            content.body = selected.text
            content.sound = .default
            
            var date = DateComponents()
            date.hour = slot.hour
            date.minute = slot.minute
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let request = UNNotificationRequest(
                identifier: identifier(for: slot),
                content: content,
                trigger: trigger
            )
            
            try await center.add(request)
        }
    }
    
    func removeAllAffirmationNotifications() {
        center.removePendingNotificationRequests(withIdentifiers: pendingIDsPrefix())
    }
    
    private func identifier(for slot: NotificationSlot) -> String {
        "affirmation.\(slot)"
    }
    
    private func pendingIDsPrefix() -> [String] {
            NotificationSlot.allCases.map { identifier(for: $0) }
        }
    
    private func isInQuietHours(hour: Int, start: Int, end: Int) -> Bool {
           if start < end {
               return hour >= start && hour < end
           } else {
               // örn 22 -> 8 (geceyi devreder)
               return hour >= start || hour < end
           }
       }
}
