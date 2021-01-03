//
//  Message.API.MessageCount.swift
//  Dear-World
//
//  Created by rookie.w on 2021/01/03.
//

import Alamofire
import Foundation

extension Message.API {
  struct MessageCount: ServiceAPI {
    typealias Response = Message.Model.MessageCount
    
    // MARK: Parameters
    private let countryCode: String?
    
    var method: HTTPMethod { .get }
    var path: String { "/api/v1/countries/messagecount" }
    var parameters: [String: Any?] {
      [
        "countryCode": countryCode
      ]
    }
    init(countryCode: String?) {
      self.countryCode = countryCode
    }
  }
}
