//
//  Date+Extensions.swift
//  PicFlow
//
//  Created by Lauv Edward on 11/4/25.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full // e.g., "1 year", "2 months"
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll // Don't show "0 days", etc.
        formatter.maximumUnitCount = 1 // Show only the largest unit (e.g., "2 months ago" instead of "2 months, 3 days ago")

        let now = Date()
        let timeInterval = now.timeIntervalSince(self)

        if timeInterval < 60 { // Less than a minute
            return "Just now"
        } else if let formattedString = formatter.string(from: timeInterval) {
            return formattedString + " ago"
        }
        return "" // Fallback
    }
}
