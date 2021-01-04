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
    let data: Message
  }
}
