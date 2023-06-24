//
//  Article.swift
//  News24
//
//  Created by GA on 19/06/2023.
//

import Foundation
import URLImage

extension Article: Codable {}
extension Article: Equatable {}
extension Article: Identifiable{
    var id: String { url }
}
extension Article {
    
    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(NewsAPIResponse.self, from: data)
        
        return apiResponse.articles ?? []
    }
}

struct Article{
   
    let source: Source
    
    let title:String
    let url:String
    let publishedAt: Date
    let author,description, urlToImage: String?
    
    var authorText: String {
        author ?? ""
    }
    var descriptionText: String {
        description ?? ""
    }
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
    var sourceText: String {
        "\(source.name)"
    }
   
   
}



struct Source{
    let name: String
}
extension Source: Codable {}
extension Source: Equatable{}
