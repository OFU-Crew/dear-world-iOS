//
//  List.swift
//  Dear-World
//
//  Created by rookie.w on 2020/12/27.
//

import Alamofire
import Foundation

extension Message.API {
  struct Messages: ServiceAPI {
    typealias Response = Message.Model.Messages
    
    // MARK: Parameters
    private let countryCode: String?
    private let lastMsgId: Int?
    private let type: Message.Model.Sort
    
    var method: HTTPMethod { .get }
    var path: String { "/api/v1/messages" }
    var parameters: [String: Any?]? {
      [
        "countryCode": countryCode,
        "type": type.rawValue,
        "lastId": lastMsgId
      ]
    }
    
    init(countryCode: String?, lastMsgId: Int?, type: Message.Model.Sort) {
      self.countryCode = countryCode
      self.lastMsgId = lastMsgId
      self.type = type
    }
  }
}
