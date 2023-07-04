//
//  ArticleRowView.swift
//  News24
//
//  Created by GA on 21/06/2023.
//

import SwiftUI


extension View {
    
    func presentShareSheet(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
}

struct ArticleRowView: View {
 
    
    @EnvironmentObject var articleBookmarkVM: ArticleBookMarkVM
    let article: Article
   
    @State  var isToogle: Bool = false
    @State var Toogled: Bool = false
    
    var body: some View {
       
        HStack(spacing: 20){
            AsyncImage(url: article.imageURL) { phase in
                switch phase {
                case.empty:
                    ProgressView()
                    
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                        
                    
                case .failure:
                    Image(systemName: "photo-fill")
                        .foregroundColor(.white)
                        .background(Color.gray)
                        
                        
                        
                @unknown default:
                    fatalError()
                }
                
            }
            .frame(width: 100, height: 100)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
            
            VStack(alignment: .leading , spacing: 4){
                Text(article.title)
                    .foregroundStyle(.black)
                    .font(.system(size: 18, weight: .semibold))
               
                
                HStack{
                    Text(article.sourceText)
                        .lineLimit(1)
                        .font(.footnote)
                        .foregroundColor(.secondary)

                    
                    
                    
                    
                    Button(action: {
                        self.Toogled.toggle()
                    }) {
                        Image(systemName: "ellipsis")
                            .padding(.leading, 200)
                            .contextMenu {
                                Button(action: {
                                    presentShareSheet(url: article.articleURL)
                                }) {
                                    Text("Share")
                                    Image(systemName: "square.and.arrow.up")
                                }
                                Button {
                                    toggleBookmark(for: article)
                                } label: {
                                    VStack(spacing: 4) {
                                        Text("Bookmark")
                                        Image(systemName: articleBookmarkVM.isBookmarked(for: article) ? "bookmark.fill" : "bookmark")
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    private func toggleBookmark(for article: Article) {
        if articleBookmarkVM.isBookmarked(for: article) {
            articleBookmarkVM.removeBookmark(for: article)
        } else {
            articleBookmarkVM.addBookmark(for: article)
        }
    }
    }





struct ArticleRowView_Previews: PreviewProvider {
    @StateObject static  var articleBookVM = ArticleBookMarkVM.shared
    
    static var previews: some View {
        NavigationView{
            List{
                ArticleRowView(article: .previewData[0])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .previewLayout(.sizeThatFits)
            }
            .listStyle(.plain)
        }
        .environmentObject(articleBookVM)
    }
    
}
