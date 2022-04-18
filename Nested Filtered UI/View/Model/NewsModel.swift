//
//  File.swift
//  Nested Filtered UI
//
//  Created by Shivaditya Kumar on 17/04/22.
//

import Foundation

struct Results: Decodable {
    let articles: [Post]
}
struct Post: Decodable, Identifiable{
    let title, description, url, urlToImage: String
    let source: Source

    var id: String {
        url
    }
}
struct Source: Decodable {
    let id: String?
}
