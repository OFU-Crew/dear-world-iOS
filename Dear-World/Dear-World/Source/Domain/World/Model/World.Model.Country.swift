//
//  World.Model.Country.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/29.
//

import Foundation

extension World.Model {
  struct Country: Decodable {
    let info: Info
    let level: Int
    let likeCount: Int
    let messageCount: Int
    let population: Int? // TODO: 타입 체크 문의해야함
    
    enum CodingKeys: String, CodingKey {
      case info = "Country"
      case level
      case likeCount
      case messageCount
      case population
    }
  }
}

extension World.Model.Country {
  struct Info: Decodable {
    let id: Int
    let code: String
    let name: String
    let emoji: String
    
    enum CodingKeys: String, CodingKey {
      case id
      case code
      case name = "fullName"
      case emoji = "emojiUnicode"
    }
  }
}
