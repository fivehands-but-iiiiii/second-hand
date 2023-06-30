//
//  Int.swift
//  second-hand
//
//  Created by SONG on 2023/06/29.
//

import Foundation

extension Int {
    func convertToMonetary() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        
        if let formattedString = numberFormatter.string(from: NSNumber(value: self)) {
            return formattedString
        } else {
            return String(self)
        }
    }
}

extension String {
    func convertToRelativeTime() -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.minute, .hour, .day], from: date, to: Date())
            
            if let minutes = components.minute, minutes < 60 {
                if minutes < 1 {
                    return "방금 전"
                } else {
                    return "\(minutes)분 전"
                }
            } else if let hours = components.hour, hours < 24 {
                return "\(hours)시간 전"
            } else if let days = components.day {
                return "\(days)일 전"
            }
        }
        
        return ""
    }
}
