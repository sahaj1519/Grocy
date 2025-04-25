//
//  GrocyApp.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

@main
struct GrocyApp: App {
    @State  var user = DataModel()
    @State  var showSplashScreen = false  // control splash visibility
    @State  var didLaunch = false         // track first cold launch
    @Environment(\.scenePhase)  var scenePhase
    
    var body: some Scene {
        WindowGroup {
            Group {
                if showSplashScreen {
                    SplashScreenView(user: user, showSplashScreen: $showSplashScreen)
                } else {
                    if user.isLoggedIn {
                        ContentView(user: user)
                    } else {
                        LoginView(user: user)
                    }
                }
            }
            .onAppear {
                // Load user data on app start
                Task {
                    do {
                        try await user.loadUserData()
                    } catch {
                        print("Error loading user data: \(error)")
                    }
                }
            }
            .onChange(of: scenePhase) { _, newPhase in
                switch newPhase {
                case .active:
                    // Show splash only on the first cold launch
                    if !didLaunch {
                        showSplashScreen = true
                        didLaunch = true
                    }
                case .background:
                    // Hide splash when app goes to background
                    showSplashScreen = false
                default:
                    break
                }
            }
        }
    }
}
