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
        MenuBarExtra {
            AppMenu()
                .environmentObject(appState)
        } label: {
            let configuration = NSImage.SymbolConfiguration(pointSize: 16, weight: .light)
                .applying(.init(paletteColors: [.red]))
            let image = NSImage(systemSymbolName: "swirl.circle.righthalf.filled", accessibilityDescription: nil)
            let updateImage = AppState.isSlackTurnedOn() ? image?.withSymbolConfiguration(configuration) : image
            
            HStack {
                Image(nsImage: updateImage!)
                Text(AppState.isSlackTurnedOn() ? "\(Util.formattedTime(AppState.getRemainingTime()))" : "")
            }
        }
            .menuBarExtraStyle(.window)
    }
}
