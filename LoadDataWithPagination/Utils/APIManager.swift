//
//  APIManager.swift
//  LoadDataWithPagination
//
//  Created by JB on 5/9/24.
//

import Foundation
import UIKit

struct Post: Codable {
    let id: Int
    let title: String
    let body:String
    let userId: Int
}

class APIManager {
    static let shared = APIManager()
    private var baseUrl = "https://jsonplaceholder.typicode.com/posts"
    private var currentPage = 1
    private var isFetching = false
    
    func fetchPosts(completion: @escaping ([Post]?) -> Void) {
        guard !isFetching else { return }
        
        isFetching = true
        let urlString = "\(baseUrl)?_page=\(currentPage)&_limit=10"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.isFetching = false }
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(posts)
                self.currentPage += 1
            } catch {
                completion(nil)
            }
        }.resume()
    }
}

class HeavyComputation {
    static func performIntensiveComputation(completion: @escaping (String) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let startTime = CFAbsoluteTimeGetCurrent()
            
            // Simulate heavy computation
            var result = 0
            for _ in 0..<100_000_000 {
                result += 1
            }
            
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            let message = "\(timeElapsed.rounded()) seconds"
            
            DispatchQueue.main.async {
                completion(message)
            }
        }
    }
}
