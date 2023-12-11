//
//  AppState.swift
//  SlackFocus
//
//  Created by Abhineet Bansal on 10/12/2023.
//

import SwiftUI

class AppState: ObservableObject {
    static let shared = AppState()
    
    static let SHORT_WORK_TIME = 5 * 60
    static let LONG_WORK_TIME = 30 * 60
    static let AD_HOC_WORK_TIME = 2
    
    enum WorkModeType {
        case invalid
        case short  // 5 min
        case long   // 30 min
    }
    
    @Published var workMode = false
    @Published var workModeType: WorkModeType = .invalid
    
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
    
    static func handleWorkModeToggle(type: WorkModeType) {
        shared.workMode.toggle()
        
        if shared.workMode {
            // If work mode has been turned on, start the timer
            shared.workModeType = type
            startTimer()
        } else {
            // If work mode has been turned off, handle slack turning off
            shared.workModeType = .invalid
            handleSlackTurnedOff()
        }
    }
    
    static func handleSlackTurnedOn(timer: Timer, isWorkMode: Bool) {
        shared.isSlackOn = true
        
        if isWorkMode {
            switch (shared.workModeType) {
            case .invalid: shared.remainingTime = AD_HOC_WORK_TIME
            case .short: shared.remainingTime = SHORT_WORK_TIME
            case .long: shared.remainingTime = LONG_WORK_TIME
            }
        } else {
            shared.remainingTime = AD_HOC_WORK_TIME
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

