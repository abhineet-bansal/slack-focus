//
//  SlackFocusApp.swift
//  SlackFocus
//
//  Created by Abhineet Bansal on 10/12/2023.
//

import SwiftUI

@main
struct SlackFocusApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate : AppDelegate
    @StateObject var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}

class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var workMode = false
    @Published var slackApp: NSRunningApplication? = nil
}
