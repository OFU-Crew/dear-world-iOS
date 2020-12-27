//
//  ResponseWrapper.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/27.
//

import Foundation

struct ResponseWrapper<Response: Decodable>: Decodable {
  let code: Int
  let message: String?
  let data: Response?
  
  enum CodingKeys: String, CodingKey {
    case code
    case message = "detailCode"
    case data
  }
}
