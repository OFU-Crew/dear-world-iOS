//
//  WorldMap.Model.Country.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/03.
//

import UIKit

extension WorldMap.Model {
  struct Country {
    let code: String
    let name: String
    let locations: [Location]
  }
  
  struct Location {
    let x: Int
    let y: Int
  }
}
extension WorldMap.Model {
  static let US = Country(
    code: "US",
    name: "United States",
    locations: [
      Location(x: 1, y: 16),
      Location(x: 1, y: 18),
      Location(x: 1, y: 20),
      Location(x: 2, y: 15),
      Location(x: 2, y: 16),
      Location(x: 2, y: 17),
      Location(x: 2, y: 18),
      Location(x: 2, y: 19),
      Location(x: 2, y: 20),
      Location(x: 3, y: 15),
      Location(x: 3, y: 16),
      Location(x: 3, y: 17),
      Location(x: 3, y: 18),
      Location(x: 3, y: 19),
      Location(x: 3, y: 20),
      Location(x: 3, y: 21),
      Location(x: 4, y: 15),
      Location(x: 4, y: 16),
      Location(x: 4, y: 17),
      Location(x: 4, y: 18),
      Location(x: 4, y: 19),
      Location(x: 4, y: 20),
      Location(x: 5, y: 16),
      Location(x: 5, y: 17),
      Location(x: 5, y: 18),
      Location(x: 5, y: 19),
      Location(x: 5, y: 20),
      Location(x: 6, y: 16),
      Location(x: 6, y: 17),
      Location(x: 6, y: 18),
      Location(x: 6, y: 19),
      Location(x: 10, y: 25),
      Location(x: 10, y: 26),
      Location(x: 10, y: 27),
      Location(x: 11, y: 25),
      Location(x: 11, y: 26),
      Location(x: 11, y: 27),
      Location(x: 11, y: 28),
      Location(x: 12, y: 25),
      Location(x: 12, y: 26),
      Location(x: 12, y: 27),
      Location(x: 12, y: 28),
      Location(x: 12, y: 29),
      Location(x: 13, y: 25),
      Location(x: 13, y: 26),
      Location(x: 13, y: 27),
      Location(x: 13, y: 28),
      Location(x: 13, y: 29),
      Location(x: 14, y: 25),
      Location(x: 14, y: 26),
      Location(x: 14, y: 27),
      Location(x: 14, y: 28),
      Location(x: 14, y: 29),
      Location(x: 15, y: 25),
      Location(x: 15, y: 26),
      Location(x: 15, y: 27),
      Location(x: 15, y: 28),
      Location(x: 15, y: 29),
      Location(x: 15, y: 30),
      Location(x: 16, y: 25),
      Location(x: 16, y: 26),
      Location(x: 16, y: 27),
      Location(x: 16, y: 28),
      Location(x: 16, y: 29),
      Location(x: 17, y: 25),
      Location(x: 17, y: 26),
      Location(x: 17, y: 27),
      Location(x: 17, y: 28),
      Location(x: 17, y: 29),
      Location(x: 18, y: 26),
      Location(x: 18, y: 27),
      Location(x: 18, y: 28),
      Location(x: 18, y: 29),
      Location(x: 19, y: 27),
      Location(x: 19, y: 28),
      Location(x: 19, y: 29),
      Location(x: 19, y: 30),
      Location(x: 20, y: 26),
      Location(x: 20, y: 27),
      Location(x: 20, y: 28),
      Location(x: 21, y: 26)
    ]
  )
}
