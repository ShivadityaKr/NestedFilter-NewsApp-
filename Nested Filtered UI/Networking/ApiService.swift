//
//  ApiService.swift
//  Nested Filtered UI
//
//  Created by Shivaditya Kumar on 17/04/22.
//

import Foundation

class RestManager : NSObject {
    func fetchData(completion: @escaping ([Post])->()) {
        let apiKey = "b35c20997175431faa0d74edd14b42f1"
        let query = "India"
        if let url = URL(string: "https://newsapi.org/v2/everything?q=\(query)&sortBy=popularity&apiKey=\(apiKey)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                completion(results.articles)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
