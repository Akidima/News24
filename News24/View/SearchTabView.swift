//
//  SearchTabView.swift
//  News24
//
//  Created by GA on 09/07/2023.
//

import SwiftUI

struct SearchTabView: View {
  @StateObject var searchVM = ArticleSearchVM.shared

    var body: some View {
      NavigationView {
        ArticleListView(articles: articles)
          .overlay(overlayView)
          .navigationTitle("Search")
      }
      .searchable(text: $searchVM.searchQuery) { suggestionsView }
      .onChange(of: searchVM.searchQuery) { newValue in
        if newValue.isEmpty {
          searchVM.phase  = .empty
        }
      }
      .onSubmit(of: .search, search)
    }

  private var articles: [Article] {
    if case let .success(articles) = searchVM.phase {
      return articles
    } else {
      return []
    }
  }

  @ViewBuilder
  private var overlayView: some View {
    switch searchVM.phase {
    case .empty:
      if !searchVM.searchQuery.isEmpty {
        ProgressView()
      } else if !searchVM.history.isEmpty {
        SearchHistoryListView(searchVM: searchVM) { newValue in
          // Need to be handled manually as it doesn't trigger default onSubmit modifier
          searchVM.searchQuery = newValue
          search()
        }
      }

      else {
        EmptyPlaceholder(text: "Search for your articles here", imageName: "Search")
      }

    case .success(let articles) where articles.isEmpty:
      EmptyPlaceholder(text: "No articles found", imageName: "No-Article")

    case .failure(let error):
      RetryView(text: error.localizedDescription, retryAction: search)

    default:
      EmptyView()
    }
  }

  @ViewBuilder
      private var suggestionsView: some View {
          ForEach(["Swift", "Covid-19", "BTC", "PS5", "iOS 15"], id: \.self) { text in
              Button {
                  searchVM.searchQuery = text
              } label: {
                  Text(text)
              }
          }
      }


  private func search() {
         let searchQuery = searchVM.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
         if !searchQuery.isEmpty {
           searchVM.addHistory(searchQuery)
         }

         Task {
             await searchVM.searchArticle()
         }
     }

  }

struct SeearchTabView_Previews: PreviewProvider {
    @StateObject static  var articleBookVM = ArticleBookMarkVM.shared

    static var previews: some View {
        SearchTabView()
            .environmentObject(articleBookVM)
    }
}
