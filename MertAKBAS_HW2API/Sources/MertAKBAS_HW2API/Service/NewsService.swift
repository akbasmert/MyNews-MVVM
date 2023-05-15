//
//  NewsService.swift
//  
//
//  Created by Mert AKBAŞ on 11.05.2023.
//

import Foundation
import Alamofire
import UIKit

public protocol PopularNewsServiceProtocol: AnyObject {
    func fetchPopularNews(key: String, completion: @escaping (Result<[News],Error>) -> Void)
}

public class PopularNewsService: PopularNewsServiceProtocol {
    
    public init() {}
    public func fetchPopularNews(key: String, completion: @escaping (Result<[News],Error>) -> Void) {
        
        let urlString = "https://api.nytimes.com/svc/topstories/v2/\(key).json?api-key=HGhvelkswdspalqFAoZjJ87OFhXxGARa"

        AF.request(urlString).responseData { response in
            switch response.result {
            case.success(let data):
                let decoder = Decoders.dateDecoder
                
                do {
                    let response = try decoder.decode(PopularNewsResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    print("********JSON DECODE ERROR**********")
                }
            case.failure(let error):
                print("********* GEÇİÇİ BİR HATA OLUŞTU \(error.localizedDescription) ***********")
                
            }
        }
    }
}
