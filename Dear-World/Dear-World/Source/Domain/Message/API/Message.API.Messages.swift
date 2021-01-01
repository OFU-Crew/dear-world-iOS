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
    private let countryId: Int
    private let lastMsgId: Int
    
    var method: HTTPMethod { .get }
    var path: String { "/api/v1/messages" }
    var parameters: [String : Any]? {
      ["countryId": countryId,
       "lastId": lastMsgId]
    }
    
    init(countryId: Int, lastMsgId: Int) {
      self.countryId = countryId
      self.lastMsgId = lastMsgId
    }
  }
}

