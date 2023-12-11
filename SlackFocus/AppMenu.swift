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
            HStack {
                Text("Slack Focus")
                    .font(.title)
                    .padding()
                
                Image(systemName: "swirl.circle.righthalf.filled")
                    .font(.system(size: 20))
                    .foregroundColor(.green)
                
                Spacer()
            }
            
            Button(action: {
                AppState.handleWorkModeToggle()
            }) {
                Text(AppState.shared.workMode ? "Stop" : "Start Slack Focus Mode")
                    .font(.title2)
                    .padding()
                    .frame(width: 220)
                    .foregroundColor(.white)
                    .background(AppState.shared.workMode ? Color.red : Color.green)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            
            Text("Time Remaining: \(Util.formattedTime(AppState.getRemainingTime()))")
                .opacity(AppState.isSlackTurnedOn() ? 1 : 0)
                .font(.title2)
                .padding()
            
            HStack {
                Spacer()
                Button(action: {
                    NSApplication.shared.terminate(nil)
                }) {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.white)
                        .padding(4)
                }
                .clipShape(Capsule())
                .padding()
            }
        }
        .frame(width: 300, height: 220)
    }
}

#Preview {
    AppMenu().environmentObject(AppState.shared)
}
