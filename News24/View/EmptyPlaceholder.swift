//
//  EmptyPlaceholder.swift
//  News24
//
//  Created by GA on 23/06/2023.
//

import SwiftUI
import Lottie

struct EmptyPlaceholder: View {
    let text: String
    let imageName: String
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            
            LottieView(animationFile: imageName)
                .frame(width: 200, height: 200)
            Text(text)
            Spacer()
        }
    }
}

struct EmptyPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPlaceholder(text: "No bookmarks", imageName: "Bookmark")
    }
}
