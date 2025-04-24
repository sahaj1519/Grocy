//
//  NewAddressView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 23/04/25.
//

import SwiftUI

struct SplashScreenView: View {
    @Bindable var user: DataModel
    @Binding var showSplashScreen: Bool

    @State private var animateShapes = false
    @State private var revealLogo = false
    @State private var revealText = false
    @State private var showMainView = false

    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            animatedCircles
            if revealLogo { logoView }
            if revealText { titleView }
        }
        .onAppear { startAnimations() }
        .fullScreenCover(isPresented: $showMainView) {
            user.isLoggedIn
                ? AnyView(ContentView(user: user))
                : AnyView(LoginView(user: user))
        }
    }

    // MARK: - Subviews

    private var animatedCircles: some View {
        ForEach(0..<10, id: \.self) { index in
            Circle()
                .fill(Color.random)
                .frame(width: 70, height: 70)
                .offset(
                    x: animateShapes ? 0 : CGFloat.random(in: -350...350),
                    y: animateShapes ? 0 : CGFloat.random(in: -350...350)
                )
                .scaleEffect(animateShapes ? 1 : 0.3)
                .opacity(animateShapes ? 1 : 0)
                .animation(
                    .easeInOut(duration: 1.5).delay(Double(index) * 0.1),
                    value: animateShapes
                )
        }
    }

    private var logoView: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .animation(.easeIn(duration: 1), value: revealLogo)
    }

    private var titleView: some View {
        VStack {
            Spacer()
            Text("Grocy")
                .font(.system(size: 52, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .shadow(radius: 1)

            Text("Smart Grocery Shopping")
                .font(.title2)
                .foregroundColor(.white.opacity(0.9))

            Spacer().frame(height: 200)
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.8), value: revealText)
    }

    // MARK: - Logic

    private func startAnimations() {
        animateShapes = true

        Task {
            try? await user.loadUserData()
        }

        withDelay(2) { revealLogo = true }
        withDelay(3) { revealText = true }
        withDelay(4) {
            showSplashScreen = false
            showMainView = true
        }
    }

    private func withDelay(_ seconds: Double, _ action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: action)
    }
}

#Preview {
    SplashScreenView(user: .preview, showSplashScreen: .constant(true))
}
