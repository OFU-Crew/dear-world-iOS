//
//  DiscoverReactor.swift
//  Dear-World
//
//  Created by rookie.w on 2020/12/27.
//

import Foundation
import ReactorKit

final class DiscoverReactor: Reactor {
  
  enum Action {
    case tapAbout
    case countryDidChanged(country: String)
    case refresh
    case loadMore
  }
  
  enum Mutation {
    case setMessages(result: [MessageMock])
    case setRefreshing(Bool)
    case addMessages(result: [MessageMock], page: Int)
    case setCountry(country: String)
    case setLoading(Bool)
    case setPresentAboutPage
  }
  
  struct State {
    var messageCount: Int = 0
    var country: String = "Whole World"
    var messages: [MessageMock] = []
    var isRefreshing: Bool = false
    var isLoading: Bool = false
    var isAnimating: Bool = false
    var currentPage: Int = 1
    @Revision var isPresentAboutPage: Void?
  }
  
  var initialState: State
  
  // MARK: 🏁 Initialize
  init() {
    self.initialState = State()
  }
  
  // MARK: 🔫 Mutate
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .countryDidChanged(country):
      return .concat(
        .just(Mutation.setCountry(country: country)),
        .just(.setLoading(true)),
        APIMock().getMessages(page: 1, country: country)
          .map { .setMessages(result: $0) },
        .just(.setLoading(false))
      )
      
    case .refresh:
      return .concat([
        .just(Mutation.setRefreshing(true)),
        APIMock().getMessages(page: 1, country: currentState.country)
          .map { .setMessages(result: $0) },
        .just(Mutation.setRefreshing(false))
      ])
      
    case .loadMore:
      return Observable<Mutation>.concat([
        APIMock().getMessages(page: 2, country: currentState.country)
          .map { Mutation.addMessages(result: $0, page: 2) }
      ])
      
    case .tapAbout:
      return .just(.setPresentAboutPage)
    }
  }
  
  // MARK: ⚡️ Reduce
  func reduce(state: State, mutation: Mutation) -> State {
    var newState: State = state
    switch mutation {
    case let .setMessages(results):
      newState.messages = results
      newState.currentPage = 1
      
    case let .setRefreshing(flag):
      newState.isRefreshing = flag
    
    case let .addMessages(result: results, page: page):
      newState.messages = state.messages + results
      newState.currentPage = page
    
    case let .setCountry(country: country):
      newState.country = country
    
    case let .setLoading(flag):
      newState.isLoading = flag
      
    case .setPresentAboutPage:
      newState.isPresentAboutPage = Void()
    }
    return newState
  }
}
