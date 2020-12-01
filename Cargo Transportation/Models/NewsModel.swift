//
//  NewsModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import Foundation

struct NewsModel: Codable {
    let status: Bool
    let message: String
    let data: [NewsModelData]
}

struct NewsModelData: Codable {
    let id: Int
    let title: String
    let publishDate: String // TODO: - Fix with appropriate date
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case id = "NewsItemId"
        case title = "Title"
        case publishDate = "PublishDate"
        case content = "Content"
    }

}
