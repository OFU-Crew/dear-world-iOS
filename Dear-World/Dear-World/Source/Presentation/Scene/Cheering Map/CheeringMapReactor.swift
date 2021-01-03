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
    case setRankers([Model.Country])
    case setCountries([Model.Country])
  }
  
  struct State {
    var messageCount: Int = 100_000
    @Revision var rankers: [Model.Country] = []
    @Revision var countries: [Model.Country] = []
    @Revision var selectedCountries: [Model.Country] = []
  }
  
  var initialState: State = State()
  
  // MARK: 🔫 Mutate
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .viewDidLoad:
      return .merge(
        Network.request(API.Map())
          .map { $0?.countries }
          .filterNil()
          .map { .setCountries($0) },
        Network.request(API.Rank())
          .map { $0?.ranking }
          .filterNil()
          .map { .setRankers($0) }
      )
      
    case .tapLikeAt(let index):
      return .empty()
    }
  }
  
  // MARK: ⚡️ Reduce
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = currentState
    switch mutation {
    case .setRankers(let countries):
      newState.rankers = countries
      
    case .setCountries(let countries):
      newState.countries = countries
      
    default:
      ()
    }
    return newState
  }
}
