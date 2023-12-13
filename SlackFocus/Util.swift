//
//  Util.swift
//  SlackFocus
//
//  Created by Abhineet Bansal on 12/12/2023.
//

import SwiftUI

class Util {
    static func formattedTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    static func getTodaysDate() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        formatter.timeZone = TimeZone.current
        return formatter.string(from: Date())
    }
}
