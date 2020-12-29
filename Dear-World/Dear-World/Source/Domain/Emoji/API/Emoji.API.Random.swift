//
//  Emoji.API.Random.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/29.
//

import Alamofire
import Foundation

extension Emoji.API {
  struct Random: ServiceAPI {
    typealias Response = Emoji.Model.Random
    
    var method: HTTPMethod { .get }
    var path: String { "emojis/random" }
  }
}
