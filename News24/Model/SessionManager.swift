//
//  SessionManager.swift
//  News24
//
//  Created by GA on 14/06/2023.
//

import Amplify

enum AuthState {
    case signup
    case login
    case confirmcode(username: String)
    case session(user: AuthUser)
}

final class SessionManager: ObservableObject {
    @Published var authState: AuthState = .login
    
    func getCurrentAuthUser(){
        if let user = Amplify.Auth.getCurrentUser() {
            authState = .session(user: user)
        } else {
            authState = .login
        }
    }
    
    func showSignUp() {
        authState = .signup
    }
    func showLogin() {
        authState = .login
    }
    func signUp(username: String, password: String, email: String) async {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        
        Amplify.Auth.signUp(
            username: username,
            password: password,
            options: options
        ) { [weak self] result in
            guard let self = self else {
                // Handle case where self is deallocated
                return
            }
            
            switch result {
            case .success(let signUpResult):
                print("Sign up result:", signUpResult)
                
                switch signUpResult.nextStep {
                case .done:
                    print("Finished sign up")
                    
                case .confirmUser(let details, _):
                    print(details ?? "No Details")
                    
                    DispatchQueue.main.async {
                        self.authState = .confirmcode(username: username)
                    }
                }
            case .failure(let error):
                print("Sign up error", error)
            }
        }
    }
    func confirm(username: String, code: String) {
        _ = Amplify.Auth.confirmSignUp(
            for: username,
            confirmationCode: code
        ) {[weak self] result in
            switch result {
            case .success(let confirmResult):
                print(confirmResult)
                if confirmResult.isSignupComplete {
                    DispatchQueue.main.async {
                        self?.showLogin()
                    }
                }
                
            case .failure(let error):
                print("Failed to confirm code", error)
            }
        }
    }
    func login(username: String, password: String){
        _ = Amplify.Auth.signIn(
            username: username,
            password: password
        ) {[weak self] result in
                
            switch result {
            case .success(let signInResult):
                print(signInResult)
                if signInResult.isSignedIn {
                    DispatchQueue.main.async {
                        self?.getCurrentAuthUser()
                    }
                   
                }
                
            case .failure(let error):
                print("Login Error", error)
            }
        }
    }
    func signOut() {
        _ = Amplify.Auth.signOut { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.getCurrentAuthUser()
                }
            case .failure(let error):
                print("Sign out Error:", error)
            }
        }
    }
    
    func resetPassword(username: String) {
            Amplify.Auth.resetPassword(for: username) { [weak self] result in
                switch result {
                case .success(let resetResult):
                    print("Reset password result:", resetResult)
                    DispatchQueue.main.async {
                        self?.getCurrentAuthUser()
                    }
                    // Handle success case
                    
                case .failure(let error):
                    print("Reset password error:", error)
                    // Handle failure case
                }
            }
        }
}

