//
//  Message.Model.Countries.swift
//  Dear-World
//
//  Created by rookie.w on 2021/01/03.
//

import Foundation

extension Message.Model {
  struct Countries: Decodable {
    let countries: [Country]
  }
}
