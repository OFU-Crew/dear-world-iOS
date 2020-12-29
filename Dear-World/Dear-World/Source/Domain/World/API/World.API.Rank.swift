//
//  World.API.Rank.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/29.
//

import Alamofire
import Foundation

extension World.API {
  struct Rank: ServiceAPI {
    typealias Response = World.Model.Rank
    
    var method: HTTPMethod { .get }
    var path: String { "countries/rank" }
  }
}
