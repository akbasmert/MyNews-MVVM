//
//  PopularNewsResponse.swift
//  
//
//  Created by Mert AKBAŞ on 11.05.2023.
//

import Foundation

public struct PopularNewsResponse: Decodable {
    public let results: [News]
    
    private enum RootCodingKeys: String, CodingKey {
        case results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.results = try container.decode([News].self, forKey: .results)
    }
}
