//
//  Message.Model.Like.swift
//  Dear-World
//
//  Created by rookie.w on 2021/01/04.
//

import Foundation

extension Message.Model {
  struct Like: Decodable {
    let like: Bool
    //FIXME :왜 평범한 메세지랑 이모지부분이 다른지 확인 후 수정할 것
    let data: TmpMessage
  }
}
extension Message.Model {
  struct TmpMessage: Decodable {
    let id: Int
//    let TmpUser: User
    let isLiked: Bool
    let likeCount: Int
    let content: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
      case id
//      case TmpUser = "anonymousUser"
      case isLiked = "like"
      case likeCount
      case content
      case createdAt
    }
  }
  
  struct TmpUUser: Decodable {
    let id: Int
    let country: TmpCountry
    let nickname: String
    let emojiId: Int
  }
  
  struct TmpCountry: Decodable {
    let code: String?
    let fullName: String
    let emojiUnicode: String
  }
}
