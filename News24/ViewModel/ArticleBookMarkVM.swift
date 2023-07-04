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
    private let bookamarkStore = PlistDataStore<[Article]>(filename: "bookmarks")
    
    static let shared = ArticleBookMarkVM()
    private init() {
        Task {
           await load()
        }
    }
    private func load() async {
        bookmarks = await bookamarkStore.load() ?? []
    }
    
    func isBookmarked(for article: Article) -> Bool {
        bookmarks.first { article.id == $0.id } != nil
    }
    
    func addBookmark(for article: Article) {
        guard !isBookmarked(for: article) else {
            return
        }
        bookmarks.insert(article, at: 0)
        bookmarkUpdated()
    }
    
    func removeBookmark(for article: Article) {
        guard let index = bookmarks.firstIndex(where: { $0.id ==  article.id }) else {
            return
        }
        bookmarks.remove(at: index)
        bookmarkUpdated()
    }
    private func bookmarkUpdated() {
        let bookmarks = self.bookmarks
        Task {
            await bookamarkStore.save(bookmarks)
        }
    }
}
