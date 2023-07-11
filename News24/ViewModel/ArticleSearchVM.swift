//
//  ArticleSearchVM.swift
//  News24
//
//  Created by GA on 09/07/2023.
//

import SwiftUI

@MainActor
class ArticleSearchVM: ObservableObject {

  @Published var phase: DataFetchPhase<[Article]> = .empty
  @Published var history = [String]()
  @Published var searchQuery = ""
  private let newsAPI = NewsAPI.shared
  private let historyDataStore = PlistDataStore<[String]>(filename: "histories")
  private let historyMaxLimit = 10
  private var trimmedSearchQuery: String {
          searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
      }

      static let shared = ArticleSearchVM()

      private init() {
          load()
      }


  func searchArticle() async {
    if Task.isCancelled { return }

    let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
    phase = .empty

    if searchQuery.isEmpty {

      return
    }
    do {
      let articles = try await newsAPI.search(for: searchQuery)
      if Task.isCancelled { return }
      phase = .success(articles)
    } catch {
      if Task.isCancelled { return }
      phase = .failure(error)
    }

  }
  func addHistory(_ text: String) {
         if let index = history.firstIndex(where: { text.lowercased() == $0.lowercased() }) {
             history.remove(at: index)
         } else if history.count == historyMaxLimit {
             history.remove(at: history.count - 1)
         }

         history.insert(text, at: 0)
         historiesUpdated()
     }
  

  func removeHistory(_ text: String) {
          guard let index = history.firstIndex(where: { text.lowercased() == $0.lowercased() }) else {
              return
          }
          history.remove(at: index)
          historiesUpdated()
      }

  func removeAllHistory() {
          history.removeAll()
          historiesUpdated()
      }

  private func load() {
          Task {
              self.history = await historyDataStore.load() ?? []
          }
      }
  private func historiesUpdated() {
          let history = self.history
          Task {
              await historyDataStore.save(history)
          }
      }

}
