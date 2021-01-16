//
//  Message.Model.Messages.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/01.
//

import Foundation

extension Message.Model {
  struct Messages: Decodable {
    let firstMsgId: Int?
    let lastMsgId: Int?
    let messageCount: Int
    let messages: [Message]
    
    enum CodingKeys: String, CodingKey {
      case firstMsgId = "firstId"
      case lastMsgId = "lastId"
      case messageCount
      case messages
    }
  }
  
  struct Message: Decodable {
    let id: Int
    let user: User
    let isLiked: Bool
    let likeCount: Int
    let content: String
    let createdAt: String
    let shareURL: String
    
    enum CodingKeys: String, CodingKey {
      case id
      case user = "anonymousUser"
      case isLiked = "like"
      case likeCount
      case content
      case createdAt
      case shareURL = "shareLink"
    }
  }
  
  struct User: Decodable {
    let id: Int
    let country: Country
    let nickname: String
    let emoji: Emoji
    
    struct Emoji: Decodable {
      let unicode: String
      let imageURL: String
      
      enum CodingKeys: String, CodingKey {
        case unicode
        case imageURL = "imageUrl"
      }
    }
  }
  
  struct Country: Decodable {
    let code: String?
    let fullName: String
    let emojiUnicode: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
      case code
      case fullName
      case emojiUnicode
      case imageURL = "imageUrl"
    }
  }
  
  enum Sort: String, CaseIterable {
    case recent = "recent"
    case weeklyHot = "weekly_hot"
    
    var title: String {
      switch self {
      case .recent:
        return "Recent"
      case .weeklyHot:
        return "Weekly Hot"
      }
    }
  }
}

extension Message.Model.Country {
  static let wholeWorld: Message.Model.Country = Message.Model.Country(
    code: nil,
    fullName: "Whole World",
    emojiUnicode: nil,
    imageURL: nil
  )
}
