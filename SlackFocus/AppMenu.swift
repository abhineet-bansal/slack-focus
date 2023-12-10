//
//  AppMenu.swift
//  SlackFocus
//
//  Created by Abhineet Bansal on 10/12/2023.
//

import SwiftUI

struct AppMenu: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Button(action: {
                handleWorkModeToggle()
            }) {
                Text(appState.workMode ? "Stop" : "Start Slack Focus Mode")
                    .font(.title2)
                    .padding()
                    .frame(width: 220)
                    .foregroundColor(.white)
                    .background(appState.workMode ? Color.red : Color.orange)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            
            Text("Time Remaining: \(formattedTime(appState.remainingTime))")
                .opacity(appState.showTimer ? 1 : 0)
                .font(.title2)
                .padding()
            
            HStack {
                Spacer()
                Button(action: {
                    NSApplication.shared.terminate(nil)
                }) {
                    Image(systemName: "trash.fill")
                        .padding(4)
                }
                .clipShape(Capsule())
                .padding()
            }
        }
        .frame(width: 300, height: 220)
    }
    
    func handleWorkModeToggle() {
        print("Toggle button clicked!")
        appState.workMode.toggle()
        
        if (!appState.workMode) {
            print("Work Mode turned off. Minimizing Slack")
            SlackHelper.minimizeSlack()
        }
    }
    
    func formattedTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

#Preview {
    AppMenu().environmentObject(AppState.shared)
}
