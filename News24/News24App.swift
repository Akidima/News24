//
//  News24App.swift
//  News24
//
//  Created by GA on 13/06/2023.
//

import Amplify
import AmplifyPlugins
import CrowdinSDK
import SwiftUI


@main
struct News24App: App {
    @StateObject var articleBookmarkVM = ArticleBookMarkVM.shared
    
    @ObservedObject var sessionManager = SessionManager()
    
    init() {
        configureAmplify()
        sessionManager.getCurrentAuthUser()
    }
    class AppDelegate: NSObject, UIApplicationDelegate{
        func application(_ application: UIApplication, didFinishLaunchingWithOptions lauchOptions:
                         [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                setUpCrowdinSDK()
                return true
        }
        func setUpCrowdinSDK() {
            let crowdinProviderConfig = CrowdinProviderConfig(hashString: "b39ed928fca86afafd4e849gwwv", sourceLanguage: "en")
            let config = CrowdinSDKConfig.config().with(crowdinProviderConfig: crowdinProviderConfig)
            
            CrowdinSDK.startWithConfig(config) {
                print("Added Successfully")
            }
            
        }
        
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
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
                    .environmentObject(articleBookmarkVM)
                
            
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
