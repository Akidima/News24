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
        NavigationView {
            ArticleListView(articles: articles)
                .onAppear {
                    Task {
                      await articleNewsVM.loadArticles()
                    }
                }
                .navigationTitle(articleNewsVM.selectedCategory.text)
            
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        Group {
            switch articleNewsVM.phase  {
                
            case .empty: ProgressView()
            
            case .success(let articles) where where articles.isEmpty:
                
            default: EmptyView()
                
            }
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


#Preview {
    NewsTabView(articleNewsVM: ArticleNewsVM(articles: Article.previewData))
}
