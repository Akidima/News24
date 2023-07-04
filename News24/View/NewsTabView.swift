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
                .overlay(overlayView)
                .task(id: articleNewsVM.fetchTaskToken, loadTask)
                .refreshable(action: refreshTask)
               
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack(spacing: 0) {
                            ImageNavView()
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                CustomSegementedPicker(fetchTaskToken: $articleNewsVM.fetchTaskToken,
                                                       selectedItemColor: .black,
                                                       backgroundColor: .clear,
                                                       selectedItemFontColor: .white,
                                                       defaultItemColor: .gray)
                                .task(id: articleNewsVM.fetchTaskToken, loadTask)
                                
                                    
                            }
                        }
                    }
                }
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch articleNewsVM.phase {
        case .empty:
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholder(text: "No articles found", imageName: "No-Article")
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: refreshTask)
        default:
            EmptyView()
        }
    }
    
    private var articles: [Article] {
        if case let .success(articles) = articleNewsVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    @Sendable
       private func loadTask() async {
           await articleNewsVM.loadArticles()
       }
       
        
        private func refreshTask() {
           DispatchQueue.main.async {
               articleNewsVM.fetchTaskToken = FetchTaskToken(category: articleNewsVM.fetchTaskToken.category, token: Date())
           }
       }
}




struct NewsTabView_Previews: PreviewProvider {
    @StateObject static  var articleBookVM = ArticleBookMarkVM.shared
    
    static var previews: some View {
        NewsTabView(articleNewsVM: ArticleNewsVM(articles: Article.previewData))
            .environmentObject(articleBookVM)
    }
}

struct ImageNavView: View {
    var body: some View {
        Image("title2")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 99, height: 24)
            
    }
}


