//
//  BookmarkTabView.swift
//  News24
//
//  Created by GA on 03/07/2023.
//

import SwiftUI

struct BookmarkTabView: View {
    @StateObject var articleNewsVM = ArticleNewsVM()
    
    @EnvironmentObject var articleBookmarkVM: ArticleBookMarkVM
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articleBookmarkVM.bookmarks)
                .overlay(overlayView(isEmpty: articleBookmarkVM.bookmarks.isEmpty))
                .navigationTitle("Bookmarked")
        }
    }
   @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholder(text: "No Bookmarks", imageName: "Bookmark")
        }
    }
}

struct BookMarkTabView_Previews: PreviewProvider {
    @StateObject static  var articleBookVM = ArticleBookMarkVM.shared
    
    static var previews: some View {
        BookmarkTabView()
            .environmentObject(articleBookVM)
    }
}
