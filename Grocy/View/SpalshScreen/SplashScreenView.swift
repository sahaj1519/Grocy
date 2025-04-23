import SwiftUI

struct SplashScreenView: View {
    @Bindable var user: DataModel
    @State private var animateShapes = false
    @State private var revealLogo = false
    @State private var revealText = false
    @State private var showMainView = false
    @Binding var showSplashScreen: Bool
    
    var body: some View {
        ZStack {
            
            Color.green
                .ignoresSafeArea()
            
            
            ForEach(0..<10, id: \.self) { index in
                Circle()
                    .fill(Color.random)
                    .frame(width: 70, height: 70)
                    .offset(x: animateShapes ? 0 : CGFloat.random(in: -350...350), y: animateShapes ? 0 : CGFloat.random(in: -350...350))
                    .scaleEffect(animateShapes ? 1 : 0.3)
                    .opacity(animateShapes ? 1 : 0)
                    .animation(
                        Animation.easeInOut(duration: 1.5)
                            .delay(Double(index) * 0.1),
                        value: animateShapes
                    )
            }
            
            
            if revealLogo {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    .opacity(revealLogo ? 1 : 0)
                    .animation(.easeIn(duration: 1), value: revealLogo)
            }
            
            
            if revealText {
                VStack {
                    Spacer()
                    Text("Grocy")
                        .font(.system(size: 52, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(radius: 1)
                        .opacity(revealText ? 1 : 0)
                        .animation(.easeInOut(duration: 0.8).delay(0.5), value: revealText)
                    
                    Text("Smart Grocery Shopping")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.9))
                        .opacity(revealText ? 1 : 0)
                        .animation(.easeInOut(duration: 0.6).delay(0.7), value: revealText)
                    
                    Spacer()
                        .frame(height: 200)
                }
                .zIndex(1)
            }
        }
        .onAppear {
            
            animateShapes = true
            Task {
                try? await user.loadUserData()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    revealLogo = true
                }
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    revealText = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    showSplashScreen = false  // Hide splash screen after animation
                }
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    showMainView = true
                }
            }
        }
        .fullScreenCover(isPresented: $showMainView) {
            if user.isLoggedIn {
                ContentView(user: user)
            } else {
                LoginView(user: user)
            }
        }
    }
}

extension Color {
    static var random: Color {
        return Color(hue: .random(in: 0...1), saturation: 0.7, brightness: 0.8)
    }
}

#Preview {
    SplashScreenView(user: .preview, showSplashScreen: .constant(true))
}
