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
}
