//
//  ApiFetcher.swift
//  SampleApp
//
//

import Foundation
import Combine

class ApiFetcher: ObservableObject {
    @Published var items = [Item]()
    
    private let baseURL = "https://qiita.com/api/v2"
    
    func fetchItems(query: String) {
        let url = URL(string: "\(baseURL)/items?query=\(query)&page=1&per_page=50")!
    
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let items = try decoder.decode([Item].self, from: data)
                    DispatchQueue.main.async {
                        self.items = items
                    }
                } else {
                    print("No Data")
                }
            } catch {
                print ("Error")
            }
            
        }.resume()
    }
}
