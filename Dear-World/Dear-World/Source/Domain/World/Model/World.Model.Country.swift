//
//  World.Model.Country.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/29.
//

import Foundation

extension World.Model {
  struct Country: Decodable {
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
