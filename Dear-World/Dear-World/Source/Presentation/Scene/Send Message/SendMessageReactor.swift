//
//  SendMessageReactor.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/29.
//

import Foundation
import ReactorKit

final class SendMessageReactor: Reactor {
  
  enum Action {
    case tapRefresh
  }
  
  enum Mutation {
    case setEmoji(String)
  }
  
  struct State {
    var emoji: String
  }
  
  let initialState: State = State(emoji: "👽")
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .tapRefresh:
      return Network.request(Emoji.API.Random())
          .filterNil()
          .map { .setEmoji($0.unicode) }
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState: State = state
    switch mutation {
    case .setEmoji(let emoji):
      newState.emoji = emoji
    }
    return newState
  }
}
