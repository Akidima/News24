//
//  SplashScreen.swift
//  News24
//
//  Created by GA on 28/06/2023.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.8
    
    var body: some View {
        VStack{
            VStack{
                Image("title")
                    .font(.system(size: 100))
                    .foregroundStyle(.blue)
            }.scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeOut(duration: 1.5)){
                        self.size = 0.9
                        self.opacity = 1.5
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            isActive = true
                    }
                }
            NavigationLink(destination: OnboardingView(), isActive: $isActive) {
                    LoginView()
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

