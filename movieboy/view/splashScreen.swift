//
//  splashScreen.swift
//  movieboy
//
//  Created by Bendegúz Timár on 12.10.23.
//

import SwiftUI
import ActivityIndicatorView

/// Splash screen to be used on app startup, while initialization loads
struct SplashScreen: View {
    /// not used, only here because ActivityIndicatorView needs it
    @State var isLoading = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(
                "SplashScreen"
            ).resizable()
            
            ActivityIndicatorView(isVisible: $isLoading, type: .flickeringDots(count: 6))
                .frame(width: 50, height: 50)
                .padding(16)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    SplashScreen()
}
