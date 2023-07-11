//
//  SessionView.swift
//  News24
//
//  Created by GA on 14/06/2023.
//

import Amplify
import ExytePopupView
import SwiftUI

struct SessionView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
  let user: AuthUser

    
    @State var showingPop = false
    var body: some View {
        VStack{
            TabView {
                NewsTabView()
                    .tabItem {
                        Image(systemName: "house")
                            
                    }
                BookmarkTabView()
                    .tabItem {
                        Image(systemName: "bookmark")
                    }

              SearchTabView()
                .tabItem {
                  Image(systemName: "magnifyingglass")
                }

              SettingsView(user: user)
                .tabItem {
                  Image(systemName: "gearshape.fill")
                }

            }.accentColor(Color.black)
        }
       
    }
}

struct SessionView_Previews: PreviewProvider {
  private struct DummyUser: AuthUser {
       let userId: String = "1"
       let username: String = "dummy"

   }

  static var previews: some View {
        SessionView(user: DummyUser())
            .environmentObject(ArticleBookMarkVM.shared)
    }
}
