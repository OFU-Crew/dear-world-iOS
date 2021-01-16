//
//  UIApplication+.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/16.
//

import UIKit

extension UIApplication {
  var version: String? {
    guard let dictionary = Bundle.main.infoDictionary,
          let version = dictionary["CFBundleShortVersionString"] as? String,
          let build = dictionary["CFBundleVersion"] as? String else { return nil }
    return "\(version).\(build)"
  }
}
