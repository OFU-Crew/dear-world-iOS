//
//  World.Model.Rank.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/29.
//

import Foundation

extension World.Model {
  struct Rank: Decodable {
    let ranking: [Country]
  }
}
