//
//  Number+.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/26.
//

import Foundation

extension Int {
  var formatted: String? {
    let numberFormatter: NumberFormatter = NumberFormatter().then {
      $0.numberStyle = .decimal
    }
    return numberFormatter.string(from: NSNumber(value: self))
  }
}
