//
//  News.swift
//  
//
//  Created by Mert AKBAŞ on 11.05.2023.
//

import Foundation

public struct NewsResult: Decodable {
    let status, copyright, section: String?
    let lastUpdated: Date?
    let numResults: Int?
    let results: [News]?

    enum CodingKeys: String, CodingKey {
        case status, copyright, section
        case lastUpdated = "last_updated"
        case numResults = "num_results"
        case results
    }
}

public struct News: Decodable {
    let title, abstract: String?
    let url: String?
    let byline: String?
    let updatedDate, createdDate, publishedDate: Date?
    let multimedia: [Multimedia]?
    let shortURL: String?

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
    let url: String?
    let height, width: Int?
}

