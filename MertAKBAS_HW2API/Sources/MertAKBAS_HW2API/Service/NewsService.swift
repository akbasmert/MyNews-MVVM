//
//  NewsService.swift
//  
//
//  Created by Mert AKBAŞ on 11.05.2023.
//

import Foundation
import UIKit

public protocol PopularNewsServiceProtocol: AnyObject {
    func fetchPopularNews( completion: @escaping (Result<[News],Error>) -> Void)
}

public class PopularNewsService: PopularNewsServiceProtocol {
    
    public init() {}
    public func fetchPopularNews( completion: @escaping (Result<[News],Error>) -> Void) {
        
        let urlStr = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=HGhvelkswdspalqFAoZjJ87OFhXxGARa"
        let decoder = Decoders.dateDecoder
        
        guard let url = URL(string: urlStr) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try decoder.decode(PopularNewsResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                print("********JSON DECODE ERROR**********")
            }
        }
        task.resume()
    }
}
