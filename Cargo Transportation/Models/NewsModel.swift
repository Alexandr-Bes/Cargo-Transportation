//
//  NewsModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import Foundation

struct NewsModel: BaseModelProtocol {
    var status: Bool
    var message: String
    var data: [NewsModelData]
}

struct NewsModelData: Codable {
    var id: Int
    var title: String
    var publishDate: String // TODO: - Fix with appropriate date
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case id = "NewsItemId"
        case title = "Title"
        case publishDate = "PublishDate"
        case content = "Content"
    }

}
