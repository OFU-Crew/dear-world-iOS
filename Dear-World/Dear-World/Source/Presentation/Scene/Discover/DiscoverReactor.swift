//
//  DiscoverReactor.swift
//  Dear-World
//
//  Created by rookie.w on 2020/12/27.
//

import Foundation
import ReactorKit
import RxOptional

final class DiscoverReactor: Reactor {
  typealias Model = Message.Model
  typealias API = Message.API
  
  enum Action {
    case viewWillAppear
    case tapAbout
    case countryDidChanged(country: Message.Model.Country?)
    case sortTypeDidChanged(sortType: Message.Model.Sort?)
    case refresh
    case loadMore
  }
  
  enum Mutation {
    case setMessages(result: Model.Messages)
    case setRefreshing(Bool)
    case addMessages(result: Model.Messages)
    case setCountry(country: Model.Country?)
    case setLoading(Bool)
    case setPresentAboutPage(Bool)
    case setMessageCount(Int)
    case setCurrentSortType(Model.Sort)
  }
  
  struct State {
    var messageCount: Int = 0
    @Revision var selectedCountry: Model.Country?
    @Revision var selectedSortType: Model.Sort = .recent
    @Revision var messages: Model.Messages = .init(
      firstMsgId: nil,
      lastMsgId: nil,
      messageCount: 0,
      messages: []
    )
    @Revision var isRefreshing: Bool = false

    var isLoading: Bool = false
    var isAnimating: Bool = false
    @Revision var isPresentAboutPage: Bool = false
  }
  
  var initialState: State
  
  // MARK: 🏁 Initialize
  init() {
    self.initialState = State()
  }
  
  // MARK: 🔫 Mutate
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .viewWillAppear:
      return .merge(
        Network.request(
          API.MessageCount(
            countryCode: currentState.selectedCountry?.code
          )
        )
        .filterNil()
        .map { Mutation.setMessageCount($0.messageCount) },
        Network.request(
          API.Messages(
            countryCode: currentState.selectedCountry?.code,
            lastMsgId: nil,
            type: .recent
          )
        )
        .filterNil()
        .map { Mutation.setMessages(result: $0) }
      )
      
    case let .countryDidChanged(country):
      return .merge(
        Network.request(
          API.MessageCount(
            countryCode: country?.code
          )
        )
        .filterNil()
        .map { .setMessageCount($0.messageCount) },
        .concat(
          .just(.setCountry(country: country)),
          .just(.setLoading(true)),
          Network.request(
            API.Messages(
              countryCode: country?.code,
              lastMsgId: nil,
              type: currentState.selectedSortType
            )
          )
          .filterNil()
          .map{ Mutation.setMessages(result: $0) },
          .just(.setLoading(false))
        )
      )
    case let .sortTypeDidChanged(sortType: sortType) :
      return .merge(
        Network.request(
          API.MessageCount(
            countryCode: currentState.selectedCountry?.code
          )
        )
        .filterNil()
        .map { .setMessageCount($0.messageCount) },
        .concat(
          .just(.setCurrentSortType(sortType ?? .recent)),
          .just(.setLoading(true)),
          Network.request(
            API.Messages(
              countryCode: currentState.selectedCountry?.code,
              lastMsgId: nil,
              type: sortType ?? .recent
            ))
            .filterNil()
            .map{ .setMessages(result: $0)},
            .just(.setLoading(false))
        )
      )
    case .refresh:
      guard currentState.isRefreshing == false else { return .empty() }
      return .merge(
        Network.request(Message.API.MessageCount(countryCode: currentState.selectedCountry?.code))
          .filterNil()
          .map(\.messageCount)
          .map{.setMessageCount($0)}
        ,.concat([
          .just(.setRefreshing(true)),
          Network.request(Message.API.Messages(countryCode: currentState.selectedCountry?.code, lastMsgId: nil, type: currentState.selectedSortType))
            .filterNil()
            .map{.setMessages(result: $0)},
          .just(.setRefreshing(false))
      ]))
    case .loadMore:
      guard !currentState.isLoading else { return .empty() }
      return Observable<Mutation>.concat([
        .just(.setLoading(true)),
        Network.request(
          API.Messages(
            countryCode: currentState.selectedCountry?.code,
            lastMsgId: currentState.messages.lastMsgId,
            type: currentState.selectedSortType
          )
        )
        .filterNil()
        .map { .addMessages(result: $0) },
        .just(.setLoading(false))
      ])
      
    case .tapAbout:
      return .just(.setPresentAboutPage(true))
    }
  }
  
  // MARK: ⚡️ Reduce
  func reduce(state: State, mutation: Mutation) -> State {
    var newState: State = state
    switch mutation {
    case let .setMessages(results):
      newState.messages = results
      
    case let .setRefreshing(flag):
      newState.isRefreshing = flag
      
    case let .addMessages(result: results):
      newState.messages = Model.Messages(
        firstMsgId: state.messages.firstMsgId,
        lastMsgId: results.lastMsgId,
        messageCount: state.messageCount + results.messageCount,
        messages: currentState.messages.messages + results.messages
      )
      
    case let .setCountry(country: country):
      newState.selectedCountry = country
      
    case let .setLoading(flag): 
      newState.isLoading = flag
      
    case .setPresentAboutPage(let isPresentAboutPage):
      newState.isPresentAboutPage = isPresentAboutPage
      
    case let .setMessageCount(count):
      newState.messageCount = count
      
    case let .setCurrentSortType(type):
      newState.selectedSortType = type
    }
    return newState
  }
}
