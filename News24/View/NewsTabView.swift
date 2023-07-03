//
//  NewsTabView.swift
//  News24
//
//  Created by GA on 21/06/2023.
//

import SwiftUI

struct NewsTabView: View {
    @StateObject var articleNewsVM = ArticleNewsVM()
    
    
    var body: some View {
        VStack{
            NavigationView {
                ArticleListView(articles: articles)
                    .overlay(overlayView)
                    .refreshable {
                        
                    }
                    .onAppear {
                        Task {
                            await articleNewsVM.loadArticles()
                        }
                    }
                    .navigationTitle(articleNewsVM.selectedCategory.text)
            }
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        
    switch articleNewsVM.phase  {
                
    case .empty:
         ProgressView()
            
    case .success(let articles) where articles.isEmpty:
        EmptyPlaceholder(text: "No articles found", imageName: "No-Article")

    case .failure(let error):  RetryView(text: error.localizedDescription) {
    }
        default: EmptyView()
    }
}
    
    private var articles:[Article] {
        if case let .success(articles) = articleNewsVM.phase {
            return articles
        } else {
            return []
        }
    }
}


struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(articleNewsVM: ArticleNewsVM(articles: Article.previewData))
    }
}
