//
//  Message.Model.SendMessage.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/29.
//

import Foundation

extension Message.Model {
  struct SendMessage: Decodable {
    let uuid: String
    let likeCount: Int
    let id: Int
    let anonymousUserId: Int
    let content: String
    let updatedAt: Date
    let createdAt: Date
  }
}
