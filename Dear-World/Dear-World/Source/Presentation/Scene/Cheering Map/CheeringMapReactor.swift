//
//  CheeringMapReactor.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/31.
//

import Foundation
import ReactorKit

final class CheeringMapReactor: Reactor {
  
  typealias API = World.API
  typealias Model = World.Model
  
  enum Action {
    case viewDidLoad
    case tapLikeAt(index: Int)
  }
  
  enum Mutation {
    case setRankers([Model.Ranker])
  }
  
  struct State {
    var messageCount: Int = -1
    @Revision var rankers: [Model.Ranker] = []
    @Revision var selectedCountries: [Model.Country] = []
  }
  
  var initialState: State = State()
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .viewDidLoad:
      return Network.request(API.Rank())
        .map { $0?.ranking }
        .filterNil()
        .map { .setRankers($0) }
      
    case .tapLikeAt(let index):
      return .empty()
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = currentState
    switch mutation {
    case .setRankers(let rankers):
      newState.rankers = rankers
    default:
      ()
    }
    return newState
  }
}