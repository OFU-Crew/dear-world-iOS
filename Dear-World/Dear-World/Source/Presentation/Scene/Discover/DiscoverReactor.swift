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
    case tapFilter
    case tapSort
    case tapShare(at: Int)
    case countryDidChanged(Model.Country?)
    case sortTypeDidChanged(Model.Sort?)
    case refresh
    case loadMore
  }
  
  enum Mutation {
    case setFirstMsgId(Int?)
    case setLastMsgId(Int?)
    case setMessages([Model.Message])
    case setRefreshing(Bool)
    case addMessages([Model.Message])
    case setShareURL(URL)
    case setCountry(Model.Country?)
    case setCountries([Model.Country])
    case setLoading(Bool)
    case setPresentAboutPage(Bool)
    case setPresentFilter(Bool)
    case setPresentSort(Bool)
    case setMessageCount(Int)
    case setCurrentSortType(Model.Sort)
  }
  
  struct State {
    @Revision var isRefreshing: Bool = false
    @Revision var isPresentAboutPage: Bool = false
    @Revision var isPresentFilter: Bool = false
    @Revision var isPresentSort: Bool = false
    @Revision var selectedCountry: Model.Country? = .wholeWorld
    @Revision var countries: [Model.Country] = []
    @Revision var selectedSortType: Model.Sort = .recent
    @Revision var shareURL: URL?
    @Revision var firstMsgId: Int?
    @Revision var lastMsgId: Int?
    @Revision var messages: [Model.Message] = []
    var messageCount: Int = 0
    var isLoading: Bool = false
    var isAnimating: Bool = false
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
        .flatMap { response -> Observable<Mutation> in
          .from([
            .setFirstMsgId(response.firstMsgId),
            .setLastMsgId(response.lastMsgId),
            .setMessages(response.messages)
          ])
        },
        Network.request(API.Countries())
          .filterNil()
          .map { .setCountries($0.countries) }
      )
      
    case .tapFilter:
      return .just(.setPresentFilter(true))
      
    case .tapSort:
      return .just(.setPresentSort(true))
      
    case .tapShare(let index):
      let urlString = currentState.messages[index].shareURL
      guard let shareURL = URL(string: urlString) else { return .empty() }
      return .just(.setShareURL(shareURL))
      
      
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
          .just(.setCountry(country)),
          .just(.setLoading(true)),
          Network.request(
            API.Messages(
              countryCode: country?.code,
              lastMsgId: nil,
              type: currentState.selectedSortType
            )
          )
          .filterNil()
          .flatMap { response -> Observable<Mutation> in
            .from([
              .setMessages(response.messages),
              .setFirstMsgId(response.firstMsgId),
              .setLastMsgId(response.lastMsgId)
            ])
          },
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
            )
          )
          .filterNil()
          .flatMap { response -> Observable<Mutation> in
            .from([
              .setMessages(response.messages),
              .setFirstMsgId(response.firstMsgId),
              .setLastMsgId(response.lastMsgId)
            ])
          }
        )
      )
    case .refresh:
      guard currentState.isRefreshing == false else { return .empty() }
      return .merge(
        Network.request(
          Message.API.MessageCount(
            countryCode: currentState.selectedCountry?.code
          )
        )
        .filterNil()
        .map(\.messageCount)
        .map { .setMessageCount($0) },
        .concat([
          .just(.setRefreshing(true)),
          Network.request(
            Message.API.Messages(
              countryCode: currentState.selectedCountry?.code,
              lastMsgId: nil,
              type: currentState.selectedSortType
            )
          )
          .filterNil()
          .flatMap { response -> Observable<Mutation> in
            .from([
              .setMessages(response.messages),
              .setFirstMsgId(response.firstMsgId),
              .setLastMsgId(response.lastMsgId)
            ])
          },
          .just(.setRefreshing(false))
        ])
      )
      
    case .loadMore:
      guard !currentState.isLoading else { return .empty() }
      return Observable<Mutation>.concat([
        .just(.setLoading(true)),
        Network.request(
          API.Messages(
            countryCode: currentState.selectedCountry?.code,
            lastMsgId: currentState.lastMsgId,
            type: currentState.selectedSortType
          )
        )
        .filterNil()
        .flatMap { response -> Observable<Mutation> in
          .from([
            .setMessages(response.messages),
            .setFirstMsgId(response.firstMsgId),
            .setLastMsgId(response.lastMsgId)
          ])
        },
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
    case .setMessages(let results):
      newState.messages = results
      
    case .setRefreshing(let flag):
      newState.isRefreshing = flag
      
    case .addMessages(let messages):
      newState.messages = currentState.messages + messages
      
    case .setCountry(let country):
      newState.selectedCountry = country
      
    case .setCountries(let countries):
      newState.countries = countries
      
    case .setLoading(let flag):
      newState.isLoading = flag
      
    case .setPresentAboutPage(let isPresentAboutPage):
      newState.isPresentAboutPage = isPresentAboutPage
      
    case .setMessageCount(let count):
      newState.messageCount = count
      
    case .setCurrentSortType(let type):
      newState.selectedSortType = type
      
    case .setPresentFilter(let isPresentFilter):
      newState.isPresentFilter = isPresentFilter
      
    case .setPresentSort(let isPresentSort):
      newState.isPresentSort = isPresentSort
      
    case .setFirstMsgId(let firstMsgId):
      newState.firstMsgId = firstMsgId
      
    case .setLastMsgId(let lastMsgId):
      newState.lastMsgId = lastMsgId
      
    case .setShareURL(let shareURL):
      newState.shareURL = shareURL
    }
    return newState
  }
}
