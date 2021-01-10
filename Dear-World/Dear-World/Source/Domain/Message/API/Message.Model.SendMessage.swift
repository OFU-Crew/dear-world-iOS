//
//  Message.Model.SendMessage.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/29.
//

import Foundation

extension Message.Model {
  struct SendMessage: Decodable {
    let id: Int
    let content: String
    let likeCount: Int
    let anonymousUserId: Int
  }
}
