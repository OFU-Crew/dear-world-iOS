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
  }
  
  struct State {
    var crews: [Crew] = []
  }
  
  let initialState: State = State()
  
  func reduce(state: State, mutation: Action) -> State {
    var newState: State = state
    switch mutation {
    case .initialize:
      newState.crews = Crew.all
    }
    return newState
  }
}
