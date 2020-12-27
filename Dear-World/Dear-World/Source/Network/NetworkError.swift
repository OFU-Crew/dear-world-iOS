//
//  Network.Error.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/27.
//

import Foundation

struct NetworkError: LocalizedError {
  var errorDescription: String?
  
  init?(code: Int, message: String?) {
    guard code == 0 else { return }
    errorDescription = message
  }
}
