//
//  ContentView.swift
//  SlackFocus
//
//  Created by Abhineet Bansal on 10/12/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Button(action: {
                handleWorkModeToggle()
            }) {
                Text(appState.workMode ? "Stop Slack Work Mode" : "Start Slack Work Mode")
                    .padding()
                    .background(appState.workMode ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .frame(width: 300, height: 200)
        
    }
    
    func handleWorkModeToggle() {
        print("Toggle button clicked!")
        appState.workMode.toggle()
        
        if (!appState.workMode) {
            print("Work Mode turned off. Minimizing Slack")
            SlackHelper.minimizeSlack()
        }
    }
}

#Preview {
    ContentView()
}

