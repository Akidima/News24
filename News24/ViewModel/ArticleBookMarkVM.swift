//
//  ArticleBookMarkVM.swift
//  News24
//
//  Created by GA on 03/07/2023.
//

import SwiftUI

@MainActor
class ArticleBookMarkVM: ObservableObject {
    
    @Published private(set) var bookmarks: [Article] = []
    
}
