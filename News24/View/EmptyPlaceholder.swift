//
//  EmptyPlaceholder.swift
//  News24
//
//  Created by GA on 23/06/2023.
//

import SwiftUI

struct EmptyPlaceholder: View {
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = self.image {
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
}

#Preview {
    EmptyPlaceholder()
}
