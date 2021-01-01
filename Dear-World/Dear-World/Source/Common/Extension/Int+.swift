//
//  Number+.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/26.
//

import Foundation

extension Int {
  var formatted: String? {
    if self > 1_000_000 {
      return self.kFormat
    } else {
      return self.decimalFormat
    }
  }
  
  var kFormat: String? {
    guard let number = (self / 1_000).decimalFormat else { return nil }
    return "\(number)K"
  }
  
  var decimalFormat: String? {
      let numberFormatter: NumberFormatter = NumberFormatter().then {
        $0.numberStyle = .decimal
      }
      return numberFormatter.string(from: NSNumber(value: self))
  }
}
