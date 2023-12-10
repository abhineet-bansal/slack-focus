//
//  AppState.swift
//  SlackFocus
//
//  Created by Abhineet Bansal on 10/12/2023.
//

import SwiftUI

class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var workMode = false
    @Published var showTimer = false
    @Published var remainingTime = 0
    @Published var slackApp: NSRunningApplication? = nil
}

