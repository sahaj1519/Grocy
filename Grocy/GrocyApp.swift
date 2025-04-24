//
//  GrocyApp.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI


@main
struct GrocyApp: App {
    @State private var user = DataModel()
    
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore = false
    @State private var isAppInBackground = false
    @State private var showSplashScreen = true  // Start with splash screen visible
    @State private var splashScreenDelay: Bool = false // Control splash screen visibility delay

    var body: some Scene {
        WindowGroup {
            Group {
                if showSplashScreen {
                    SplashScreenView(user: user, showSplashScreen: $showSplashScreen)
                        .onAppear {
                            // Delay hiding splash screen to make it visible for a reasonable time
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) { // Show splash for 4 seconds
                                if user.isLoggedIn {
                                    showSplashScreen = false
                                } else {
                                    showSplashScreen = false
                                }
                            }
                        }
                } else {
                    if user.isLoggedIn {
                        ContentView(user: user)
                    } else {
                        LoginView(user: user)
                    }
                }
            }
            .onAppear {
                // Load user data and set launch state
                
                Task {
                    do {
                        try await user.loadUserData()
                        
                        if !hasLaunchedBefore {
                            hasLaunchedBefore = true
                        }
                    } catch {
                        print("Error loading user data")
                    }
                }
            }
            .onChange(of: isAppInBackground) { _, newValue in
                if newValue {
                    // App went to background, prepare for splash on return if app was terminated
                    showSplashScreen = true
                }
            }
            .onAppear {
                // Monitor app background/foreground state
                NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { _ in
                    isAppInBackground = true
                }

                NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { _ in
                    isAppInBackground = false
                    // If user is already logged in, don't show splash
                    if user.isLoggedIn {
                        showSplashScreen = false
                    }
                }
            }
        }
    }
}
