//
//  NewsAPIResponse.swift
//  News24
//
//  Created by GA on 19/06/2023.
//

import Foundation

struct NewsAPIResponse: Decodable {
    
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
}
