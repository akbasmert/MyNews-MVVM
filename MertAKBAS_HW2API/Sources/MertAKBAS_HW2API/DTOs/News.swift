//
//  News.swift
//  
//
//  Created by Mert AKBAŞ on 11.05.2023.
//

import Foundation

public struct NewsResult: Decodable {
    public let status, copyright, section: String?
    public let lastUpdated: Date?
    public let numResults: Int?
    public let results: [News]?

    enum CodingKeys: String, CodingKey {
        case status, copyright, section
        case lastUpdated = "last_updated"
        case numResults = "num_results"
        case results
    }
}

public struct News: Decodable {
    public let title, abstract: String?
    public let url: String?
    public let byline: String?
    public let updatedDate, createdDate, publishedDate: Date?
    public let multimedia: [Multimedia]?
    public let shortURL: String?

    enum CodingKeys: String, CodingKey {
        case title, abstract, url, byline
        case updatedDate  = "updated_date"
        case createdDate  = "created_date"
        case publishedDate = "published_date"
        case multimedia
        case shortURL = "short_url"
    }
}

public struct Multimedia: Decodable {
    public let url: String?
    public let height, width: Int?
}

