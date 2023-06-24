//
//  SafariView.swift
//  News24
//
//  Created by GA on 21/06/2023.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> some SFSafariViewController {
         SFSafariViewController(url: url)
        
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
}

