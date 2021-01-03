//
//  World.Model.Map.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/04.
//

import Foundation

extension World.Model {
  struct Map: Decodable {
    let countries: [Country]
  }
}
