//
//  News.swift
//  
//
//  Created by Mert AKBAŞ on 11.05.2023.
//

import Foundation

public struct NewsResult: Decodable {
    public let results: [News]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

public struct News: Decodable {
    public let title, abstract: String?
    public let url: String?
    public let byline: String?
    public let multimedia: [Multimedia]?

    enum CodingKeys: String, CodingKey {
        case title, abstract, url, byline
        case multimedia
    }
}

public struct Multimedia: Decodable {
    public let url: String?
}

