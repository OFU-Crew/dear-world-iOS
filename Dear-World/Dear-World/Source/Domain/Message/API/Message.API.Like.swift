//
//  Message.API.Like.swift
//  Dear-World
//
//  Created by rookie.w on 2021/01/04.
//

import Alamofire
import Foundation

extension Message.API {
  struct Like: ServiceAPI {
    typealias Response = Message.Model.Like
    
    // MARK: Parameters
    private let messageId: String
    
    var method: HTTPMethod { .post }
    var path: String { "api/v1/messages/\(messageId)/like" }
    var parameters: [String: Any?]? { nil }
    
    init(messageId: String) {
      self.messageId = messageId
    }
  }
}
