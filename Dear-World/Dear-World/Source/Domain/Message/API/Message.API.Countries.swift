//
//  Message.API.Countries.swift
//  Dear-World
//
//  Created by rookie.w on 2021/01/03.
//

import Alamofire
import Foundation

extension Message.API {
  struct Countries: ServiceAPI {
    typealias Response = Message.Model.Countries
    
    var method: HTTPMethod { .get }
    var path: String { "api/v1/countries/" }
    var parameters: [String : Any?]? { nil } 
  }
}
