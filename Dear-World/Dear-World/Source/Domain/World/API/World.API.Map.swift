//
//  World.API.Map.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/04.
//

import Alamofire
import Foundation

extension World.API {
  struct Map: ServiceAPI {
    typealias Response = World.Model.Map
    
    var method: HTTPMethod { .get }
    var path: String { "api/v1/countries/count" }
    var parameters: [String : Any?]? { nil }
  }
}
