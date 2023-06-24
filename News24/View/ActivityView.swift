//
//  ActivityView.swift
//  News24
//
//  Created by GA on 21/06/2023.
//

import SwiftUI
import UIKit


struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities:applicationActivities)
        
        return activityController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
}
