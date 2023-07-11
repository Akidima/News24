//
//  SettingsView.swift
//  News24
//
//  Created by GA on 09/07/2023.
//

import SwiftUI
import Amplify

struct SettingsView: View {

  @EnvironmentObject var sessionManager: SessionManager

  let user: AuthUser

  enum WebLink: String, Identifiable {
    case twitter = "https://twitter.com/GeorgeAkidima"
    case linkedlin = "https://www.linkedin.com/in/akidima-george-a00223185/"
    case github = "https://github.com/Akidima"
    var id: UUID {
      UUID()
    }
  }

  @State private var link: WebLink?
  @State private var showAlert = false

    var body: some View {

      NavigationStack{

        List {
          Section {
            Label("Welcome, \(user.username)", systemImage: "person.fill")
          }
          
          Section {
              Label("Follow on Twitter", image: "Twitter 1")
                  .onTapGesture {
                      link = .twitter
                  }

              Label("Let's connect on Linkedin", image: "LinkedIn")
                  .onTapGesture {
                      link = .linkedlin
                  }

              Label("For More Projects", image: "GitHub")
                  .onTapGesture {
                      link = .github
                  }

            Section {
              Button(action: {
                showAlert = true
              }) {
                HStack(spacing: 4){
                  Image("Logout")

                  Text("Log Out")
                    .font(.headline)
                    .foregroundColor(.red)
                }.alert(isPresented: $showAlert) {
                    Alert(
                      title: Text("Log out"),
                      message: Text("Are you sure you want to log out?"),
                      primaryButton: .destructive(Text("Log Out"), action: {
                        sessionManager.signOut()
                      }),
                      secondaryButton: .cancel()
                    )
                }
              }

              Button(action: {
                showAlert = true
              }) {
                Text("Delete User")
                  .font(.headline)
                  .foregroundColor(.blue)
                }.alert(isPresented: $showAlert) {
                  Alert(
                    title: Text("Delete"),
                    message: Text("Are you sure you want to delete this account?"),
                    primaryButton: .destructive(Text("Delete"), action: {
                      sessionManager.deleteUser()
                          }),
                    secondaryButton: .cancel()
                  )
                }
            }

          }


        }
        .listStyle(GroupedListStyle())

        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.automatic)
        .sheet(item: $link) { item in
            if let url = URL(string: item.rawValue) {
                SafariView(url: url)
            }
        }
      }
    }
}

struct SettingsView_Previews: PreviewProvider {
  private struct DummyUser: AuthUser {
       let userId: String = "1"
       let username: String = "dummy"

   }


    static var previews: some View {
      SettingsView( user: DummyUser())

    }
}
