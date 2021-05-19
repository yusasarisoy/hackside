//
//  NetworkManager.swift
//  hackside
//
//  Created by Yuşa on 19.05.2021.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, resposnse, error in
                if let error = error {
                    print("An error occurred while starting URL session:", error.localizedDescription)
                } else {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch {
                            print("An error occurred while decoding the data:", error.localizedDescription)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
