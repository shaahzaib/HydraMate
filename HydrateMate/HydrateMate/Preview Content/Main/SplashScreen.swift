//
//  SplashScreen.swift
//  HydrateMate
//
//  Created by Macbook Pro on 28/05/2025.
//

import SwiftUI

struct SplashView: View {
    @State private var isAnimating = false
    @State private var showAppContent = false
    
    var body: some View {
        ZStack {
            
            if showAppContent {
                // Your main app content will go here
                ContentView()
            } else {
                // Splash screen
                LinearGradient(
                    gradient: Gradient(colors: [Color.cyan,Color.purple]), startPoint:.topLeading , endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Water droplet animation
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 120, height: 120)
                            .scaleEffect(isAnimating ? 1.5 : 0.8)
                            .opacity(isAnimating ? 0 : 0.5)
                        
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 100, height: 100)
                            .scaleEffect(isAnimating ? 1.3 : 0.9)
                            .opacity(isAnimating ? 0 : 0.7)
                        
                        Image(systemName: "drop.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.blue)
                            .frame(width: 60, height: 60)
                            .scaleEffect(isAnimating ? 1.2 : 1.0)
                            .rotationEffect(.degrees(isAnimating ? 5 : -5))
                    }
                    
                    // App name with animation
                    Text("HydraMate")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                        .scaleEffect(isAnimating ? 1.05 : 0.95)
                        .opacity(isAnimating ? 1 : 0)
                    
                    // Tagline
                    Text("Stay Hydrated, Stay Healthy")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : 20)
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                        isAnimating = true
                    }
                    
                    // Transition to main content after delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showAppContent = true
                        }
                    }
                }
            }
        }
        
        
        
    }
}

// Preview
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SplashView()
        }
    }
}


