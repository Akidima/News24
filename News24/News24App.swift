//
//  News24App.swift
//  News24
//
//  Created by GA on 13/06/2023.
//

import Amplify
import AmplifyPlugins
import SwiftUI


@main
struct News24App: App {
    @ObservedObject var sessionManager = SessionManager()
    
    init() {
        configureAmplify()
        sessionManager.getCurrentAuthUser()
    }
    var body: some Scene {
        WindowGroup {
            switch sessionManager.authState{
            case .login:
                LoginView()
                    .environmentObject(sessionManager)
                
            case .signup:
                SignupView()
                    .environmentObject(sessionManager)
                
            case .confirmcode(let username):
                ConfirmationView(username: username)
                    .environmentObject(sessionManager)
                
            case .session(let user):
                SessionView(user: user)
                    .environmentObject(sessionManager)
                
            
            }
            
        }
    }
    private func configureAmplify(){
        do {
            Amplify.Logging.logLevel = .verbose
            
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured with auth plugin")
        } catch{
            print("Failed to initalize Amplify with \(error)")
        }
    }
}
