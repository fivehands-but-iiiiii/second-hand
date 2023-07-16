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
            let components = calendar.dateComponents([.minute, .hour, .day, .month], from: date, to: Date())
            
            if let months = components.month, months > 0 {
                return "\(months)개월 전"
            } else if let days = components.day, days > 0 {
                return "\(days)일 전"
            } else if let hours = components.hour, hours > 0 {
                return "\(hours)시간 전"
            } else if let minutes = components.minute, minutes > 0 {
                return "\(minutes)분 전"
            } else {
                return "방금 전"
            }
        }
        
        return ""
    }
}
