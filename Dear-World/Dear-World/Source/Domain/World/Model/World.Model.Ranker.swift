//
//  World.Model.Ranker.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/31.
//

import Foundation

extension World.Model {
  struct Ranker: Decodable {
    let messageCount: Int
    let likeCount: Int
    let population: Int?
    let level: String
    let country: Country
  }
}
