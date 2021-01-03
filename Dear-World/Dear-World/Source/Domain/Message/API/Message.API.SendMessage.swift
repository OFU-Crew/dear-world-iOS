//
//  Message.API.SendMessage.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/29.
//

import Alamofire
import Foundation

extension Message.API {
  struct SendMessage: ServiceAPI {
    typealias Response = Message.Model.SendMessage
    
    // MARK: Parameters
    private let countryCode: String
    private let emojiId: Int
    private let name: String
    private let message: String
    
    var method: HTTPMethod { .post }
    var path: String { "api/v1/messages" }
    var parameters: [String: Any?]? {
      ["countryCode": countryCode,
       "emojiId": emojiId.description,
       "nickname": name,
       "content": message]
    }
    
    init(countryCode: String, emojiId: Int, name: String, message: String) {
      self.countryCode = countryCode
      self.emojiId = emojiId
      self.name = name
      self.message = message
    }
  }
}
