//
//  ConfirmationView.swift
//  News24
//
//  Created by GA on 13/06/2023.
//

import SwiftUI

struct ConfirmationView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var confirmationCode = ""
    
    let username: String
    
    var body: some View {
        VStack{
            VStack{
                Text("Username: \(username)")
                    .font(.system(.headline, design: .rounded))
                
                TextField("Confirmation Code", text: $confirmationCode)
                    .frame(width: 200, height: 20)
                    .border(2, .gray.opacity(0.5))
                
                Button(action: {
                    sessionManager.confirm(
                        username: username,
                        code: confirmationCode
                    )
                }) {
                    Text("Confirm")
                        .font(.system(size: 20))
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.heavy)
                        .frame(width: 150, height: 40)
                }.tint(Color.black)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 30))
                  
                   
            }.padding()
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(username: "")
    }
}

extension View {
    func border(_ width: CGFloat, _ color: Color) -> some View{
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background{
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }
}

