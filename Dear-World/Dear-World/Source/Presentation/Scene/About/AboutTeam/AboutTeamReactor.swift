//
//  AboutTeamReactor.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/04.
//

import ReactorKit

final class AboutTeamReactor: Reactor {
  enum Action {
    case initialize
    case tapBack
  }
  
  struct State {
    var crews: [Crew] = []
    @Revision var isWillDismiss: Bool = false
  }
  
  let initialState: State = State()
  
  func reduce(state: State, mutation: Action) -> State {
    var newState: State = state
    switch mutation {
    case .initialize:
      newState.crews = Crew.all
      
    case .tapBack:
      newState.isWillDismiss = true
    }
    return newState
  }
}
