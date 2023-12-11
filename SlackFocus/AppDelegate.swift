//
//  AppDelegate.swift
//  SlackFocus
//
//  Created by Abhineet Bansal on 10/12/2023.
//

import SwiftUI
import Combine

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Add an observer for application activation
        NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.didActivateApplicationNotification,
            object: nil,
            queue: nil) { [weak self] notification in
                guard let self = self,
                      let info = notification.userInfo,
                      let app = info[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication else {
                    return
                }

                if app.localizedName == "Slack" {
                    handleSlackActivated(slackApp: app)
                }
        }
    }
    
    func handleSlackActivated(slackApp: NSRunningApplication?) {
        // Set the slack app, if not already set
        AppState.updateSlackApp(slackApp: slackApp)
        
        // If Slack is already on, do nothing
        if AppState.isSlackTurnedOn() {
            return
        }
        
        print("Slack is activated")
        AppState.startTimer()
    }
}
