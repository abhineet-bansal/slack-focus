//
//  AppDelegate.swift
//  SlackFocus
//
//  Created by Abhineet Bansal on 10/12/2023.
//

import SwiftUI
import Combine

class AppDelegate: NSObject, NSApplicationDelegate {
    @EnvironmentObject var appState: AppState
    var timer: Timer?
    
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
                    print("Slack is activated!")
                    AppState.shared.slackApp = app
                    
                    let isWorkMode = AppState.shared.workMode
                    print("Work mode is \(isWorkMode)")
                    
                    // Schedule a timer to minimize Slack after 60 seconds
                    let timerDuration: TimeInterval = isWorkMode ? 10 : 5
                        self.timer = Timer.scheduledTimer(withTimeInterval: timerDuration, repeats: false) { _ in
                            SlackHelper.minimizeSlack()
                        }
                }
        }
    }
}
