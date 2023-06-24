//
//  ContentView.swift
//  News24
//
//  Created by GA on 13/06/2023.
//

import SwiftUI

struct SecureTextField: View {
    @State private var isSecureField:Bool = true
    @Binding var text:String
    
    var body: some View {
        
        HStack{
            if isSecureField {
                SecureField("Password", text: $text)
                    .textFieldStyle(.plain)
            }
            else {
                TextField(text, text: $text)
            }
        }.overlay(alignment: .trailing) {
            Image(systemName: isSecureField ? "eye.slash" : "eye")
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
    }
}

struct LoginView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
   
    
    @State private var password: String = ""
    @State private var username = ""
    @State private var showSignUpView = false
    @State private var showWalkthrough = true
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("title")
                    .frame(width: 90, height: 135)
                    
                VStack(alignment: .leading){
                    TextField("Username", text: $username)
                        .textFieldStyle(.plain)
                    
                    
                    Rectangle()
                        .frame(width: 370, height: 1)
                        .foregroundColor(Color.gray.opacity(1))
                    }.padding(.top, 20)
                    .padding()
                
                VStack(alignment: .leading){
                    SecureTextField(text: $password)
                    
                    Rectangle()
                        .frame(width: 370, height: 1)
                        .foregroundColor(Color.gray.opacity(1))
                    }.padding(.top, 30)
                    .padding()
                
                Button(action: {
                    sessionManager.login(
                        username: username,
                        password: password
                    )
                }) {
                    Text("Sign In")
                        .font(.system(size: 20))
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.heavy)
                        .frame(width: 150, height: 40)
                }.tint(Color.black)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 30))
                   .padding(.top, 30)
                   
                HStack{
                    Rectangle()
                        .frame(width: 96, height: 1)
                    Text("or sign in with")
                        .frame(width: 106, height: 43)
                    Rectangle()
                        .frame(width: 96, height: 1)
                }.padding(.top, 20)
                
                HStack(spacing: 20){
                    Button(action: {}) {
                        Image("email")
                    }
                    Button(action: {}) {
                        Image("gmail")
                    }
                    Button(action: {}) {
                        Image("facebook")
                    }
                    Button(action: {}) {
                        Image("twitter")
                    }
                    Button(action: {}) {
                        Image("apple")
                    }
                }.padding(.top, 30)
                
                ZStack {
                            NavigationView {
                                HStack {
                                    NavigationLink(destination: LoginView()) {
                                        Text("Don't have an account ?")
                                            .foregroundColor(.black)
                                            .fontWeight(.medium)
                                    }
                                    
                                    
                                    Button(action: {
                                        sessionManager.showSignUp()
                                        showSignUpView = true
                                    }) {
                                        Text("Register")
                                            .foregroundColor(.black)
                                            .fontWeight(.heavy)
                                    }
                                    
                                }
                            }
                            
                            if showSignUpView {
                                SignupView()
                            }
                        } .edgesIgnoringSafeArea(.all)
            }.padding(.top, 30)
            
        }.sheet(isPresented: $showWalkthrough) {
            OnboardingView()
        }
            
    
        
       

    }
}

struct SignupView: View {
    func SignUp(){
        Task {
            await sessionManager.signUp(username: username, password: password, email: email)
        }
    }
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
   
   
    var body: some View {
        VStack {
            Image("title")
                .frame(width: 90, height: 135)
            
            
                VStack(alignment: .leading) {
                    TextField("Username", text: $username)
                        .textFieldStyle(.plain)
                    
                    
                    Rectangle()
                        .frame(width: 370, height: 1)
                        .foregroundColor(Color.gray.opacity(1))
                }.padding(.top, 20)
                    .padding()
                
                VStack(alignment: .leading) {
                    TextField("Email", text: $email)
                        .textFieldStyle(.plain)
                    
                    
                    Rectangle()
                        .frame(width: 370, height: 1)
                        .foregroundColor(Color.gray.opacity(1))
                }.padding(.top, 20)
                    .padding()
                
                VStack(alignment: .leading) {
                    SecureTextField(text: $password)
                    
                    
                    Rectangle()
                        .frame(width: 370, height: 1)
                        .foregroundColor(Color.gray.opacity(1))
                }.padding(.top, 30)
                    .padding()
            
            
            
           
            
            Button(action: {SignUp()}) {
                Text("Sign Up")
                    .font(.system(size: 20))
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.heavy)
                    .frame(width: 150, height: 40)
            }.tint(Color.black)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 30))
            .padding(.top, 30)
            
            HStack{
                Rectangle()
                    .frame(width: 96, height: 1)
                
                Text("or sign in with")
                    .frame(width: 106, height: 43)
                
                Rectangle()
                    .frame(width: 96, height: 1)
            }.padding(.top, 20)
            
            HStack(spacing: 40){
               Button(action: {}) {
                    Image("gmail")
                }
                Button(action: {}) {
                    Image("facebook")
                }
                Button(action: {}) {
                    Image("twitter")
                }
                Button(action: {}) {
                    Image("apple")
                }
            }.padding(.top, 30)
            
               
            
            VStack{
                Text("By signing up to News24 you are accepting our")
                Text("Terms & Conditions")
                        .fontWeight(.bold)
            }.padding(.top, 35)
            
        }
        .padding(.top, 30)
    }
}




struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            
        
       
    }
}


struct SignupView_Previews: PreviewProvider {
   static var previews: some View {
        SignupView()
    }
}



