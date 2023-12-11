//
//  SlackHelper.swift
//  SlackFocus
//
//  Created by Abhineet Bansal on 10/12/2023.
//

import SwiftUI

class SlackHelper {
    static func minimizeSlack() {
        guard let slackApp = AppState.shared.slackApp else {
            print("Slack app couldn't be found")
            return
        }

        // Minimize the Slack app
        print("Hiding Slack")
        slackApp.performSelector(onMainThread: #selector(NSRunningApplication.hide), with: nil, waitUntilDone: true)
    }
}
