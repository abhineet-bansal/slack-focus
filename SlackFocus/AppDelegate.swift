//
//  AppDelegate.swift
//  SlackFocus
//
//  Created by Abhineet Bansal on 10/12/2023.
//

import SwiftUI
import Combine

class AppDelegate: NSObject, NSApplicationDelegate {
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
                    AppState.shared.showTimer = true
                    
                    let isWorkMode = AppState.shared.workMode
                    print("Work mode is \(isWorkMode)")
                    
                    let timerDuration: TimeInterval = isWorkMode ? 30 * 60 : 60
                    startTimer(duration: Int(timerDuration))
                }
        }
    }
    
    func startTimer(duration: Int) {
        stopTimer() // Make sure to stop any existing timer

        AppState.shared.remainingTime = duration
        print("Starting with time: \(duration)")
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in

            AppState.shared.remainingTime -= 1

            if AppState.shared.remainingTime <= 0 {
                AppState.shared.workMode = false
                AppState.shared.showTimer = false
                
                SlackHelper.minimizeSlack()
                self.stopTimer()
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
