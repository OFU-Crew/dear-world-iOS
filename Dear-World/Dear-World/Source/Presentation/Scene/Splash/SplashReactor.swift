//
//  SplashReactor.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/29.
//

import Foundation
import ReactorKit

final class SplashReactor: Reactor {
  enum Action {
    case entry
  }
  
  struct State {
    let lottie: String = ""
  }
  
  let initialState: State = State()
  
}
