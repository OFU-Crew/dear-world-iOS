//
//  Emoji.Model.Random.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/29.
//

import Foundation

extension Emoji.Model {
  struct Random: Decodable {
    let id: Int?
    let unicode: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
      case id
      case unicode
      case imageURL = "imageUrl"
    }
  }
}
