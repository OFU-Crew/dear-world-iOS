//
//  Message.Model.Messages.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/01.
//

import Foundation

extension Message.Model {
  struct Messages: Decodable {
    let firstMsgId: Int
    let lastMsgId: Int
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
    let id: String
    // TODO: 🔮 anonymousUser 모델 구현
    let isLiked: Bool
    let likeCount: Int
    let content: String
    let createAt: Date
    
    enum CodingKeys: String, CodingKey{
      case id = "uuid"
      case isLiked = "like"
      case likeCount
      case content
      case createAt
    }
  }
}
