//
//  Message.Model.MessageCount.swift
//  Dear-World
//
//  Created by rookie.w on 2021/01/03.
//

import Foundation

extension Message.Model {
  struct MessageCount: Decodable {
    let country: String
    let messageCount: Int
  }
}
