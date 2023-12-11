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
    
    @Published var isSlackOn = false
    @Published var remainingTime = 0
    
    @Published var timer: Timer?
    @Published var slackApp: NSRunningApplication? = nil
    
    
    static func isWorkModeEnabled() -> Bool {
        return shared.workMode
    }
    
    static func isSlackTurnedOn() -> Bool {
        return shared.isSlackOn
    }
    
    static func decrementRemainingTime() {
        shared.remainingTime -= 1
    }
    
    static func getRemainingTime() -> Int {
        return shared.remainingTime
    }
    
    static func updateSlackApp(slackApp: NSRunningApplication?) {
        if shared.slackApp == nil {
            shared.slackApp = slackApp
        } else {
            print("UpdateSlackApp invoked when Slack app was already set!")
        }
    }
    
    static func handleWorkModeToggle() {
        shared.workMode.toggle()
        print("Work mode set to \(shared.workMode)")
        
        if shared.workMode {
            // If work mode has been turned on, start the timer
            startTimer()
        } else {
            // If work mode has been turned off, handle slack turning off
            handleSlackTurnedOff()
        }
    }
    
    static func handleSlackTurnedOn(timer: Timer, isWorkMode: Bool) {
        shared.isSlackOn = true
        
        if isWorkMode {
            shared.remainingTime = 30 * 60
        } else {
            shared.remainingTime = 60
        }
        
        shared.timer = timer
    }
    
    static func handleSlackTurnedOff() {
        shared.isSlackOn = false
        
        shared.remainingTime = 0
        shared.workMode = false
        
        if shared.timer != nil {
            shared.timer?.invalidate()
            shared.timer = nil
        }
        
        SlackHelper.minimizeSlack()
    }
    
    static func startTimer() {
        // Clear timer before starting
        if shared.timer != nil {
            shared.timer?.invalidate()
            shared.timer = nil
        }

        let timer: Timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            decrementRemainingTime()

            if getRemainingTime() <= 0 {
                handleSlackTurnedOff()
            }
        }
        
        handleSlackTurnedOn(timer: timer, isWorkMode: AppState.shared.workMode)
    }
}

