//
//  ArticleListView.swift
//  News24
//
//  Created by GA on 21/06/2023.
//

import SwiftUI

struct ArticleListView: View {
    let articles: [Article]
    @State private var selectedArticle: Article?
    
    var body: some View {
        NavigationView {
            List{
                    ForEach(articles) { article in
                        ArticleRowView(article: article)
                            .onTapGesture {
                                selectedArticle = article
                            }
                    }.listRowSeparator(.visible, edges: .bottom)
                }
                .listStyle(.plain)
                .sheet(item: $selectedArticle) {
                    SafariView(url: $0.articleURL)
                        .edgesIgnoringSafeArea(.bottom)
                }
            }
        
    }
}

struct ArticleListView_Previews: PreviewProvider{
    @StateObject static  var articleBookVM = ArticleBookMarkVM.shared
    
    static var previews: some View {
        NavigationView {
            ArticleListView(articles: Article.previewData)
                .environmentObject(articleBookVM)
        }
    }
}
