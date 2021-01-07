//
//  SendMessageReactor.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/29.
//

import Foundation
import ReactorKit
import SwiftRichString
import Then

final class SendMessageReactor: Reactor {
  
  typealias API = Message.API
  typealias Model = Message.Model
  
  enum Action {
    case initialize
    case tapClose
    case tapRefresh
    case typeName(String)
    case typeMessage(String)
    case tapSendMessage
    case confirmAlert
  }
  
  enum Mutation {
    case setEmojiId(Int)
    case setEmoji(String)
    case setName(String)
    case setMessage(String)
    case setPresent(Bool)
    case setPresentAlert(Bool)
    case setCountry(Model.Country)
  }
  
  struct State: Then {
    @Revision var isPresented: Bool = true
    @Revision var isPresentAlert: Bool = false
    var emoji: String = "👽"
    var canSendMessage: Bool = false
    var name: String = ""
    var message: String = ""
    var nameStatusMessage: NSAttributedString = NSAttributedString(string: "0/15")
    var messageLimitGauge: Float = 0.0
    var messageStatusMessage: NSAttributedString = NSAttributedString(string: "0/300")
    var selectedCountry: Model.Country?
    fileprivate var emojiId: Int = 21
    fileprivate let nameCountLimit: Int = 15
    fileprivate let messageCountLimit: Int = 300
  }
  
  // MARK: 🎨 Style
  enum Styles {
    static let empty: Style = Style {
      $0.color = Color.grayWhite
      $0.font = Font.systemFont(ofSize: 14, weight: .medium)
    }
    static let normal: Style = Style {
      $0.color = Color.warmBlue
      $0.font = Font.systemFont(ofSize: 14, weight: .medium)
    }
    static let fulfil: Style = Style {
      $0.color = Color.livelyBlue
      $0.font = Font.systemFont(ofSize: 14, weight: .medium)
    }
  }
  
  let initialState: State = State()
  
  // MARK: 🔫 Mutate
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .initialize:
      return .empty()
      
    case .tapClose:
      return .just(.setPresent(false))
      
    case .tapRefresh:
      return Network.request(Emoji.API.Random())
        .filterNil()
        .flatMap {
          Observable<Mutation>.from([
            .setEmojiId($0.id),
            .setEmoji($0.unicode)
          ])
        }
      
    case .typeName(let name):
      return .just(.setName(name))
      
    case .typeMessage(let message):
      return .just(.setMessage(message))
      
    case .tapSendMessage:
      return .just(.setPresentAlert(true))
      
    case .confirmAlert:
      let api: API.SendMessage = API.SendMessage(
        countryCode: "KR",
        emojiId: currentState.emojiId,
        name: currentState.name,
        message: currentState.message
      )
      return .concat(
        Network.request(api)
          .filterNil()
          .flatMap { _ in Observable<Mutation>.empty() },
        .just(.setPresent(false))
      )
    }
  }
  
  // MARK: ⚡️ Reduce
  func reduce(state: State, mutation: Mutation) -> State {
    var newState: State
    switch mutation {
    case .setPresent(let isPresented):
      newState = state.with {
        $0.isPresented = isPresented
      }
      
    case .setPresentAlert(let isPresentAlert):
      newState = state.with {
        $0.isPresentAlert = isPresentAlert
      }
      
    case .setEmoji(let emoji):
      newState = state.with {
        $0.emoji = emoji
      }
      
    case .setName(let name):
      // FIXME: 🐛 네임 텍스트필드랑 불일치 문제 수정
      let name: String = name.count <= state.nameCountLimit ? name : state.name
      newState = state.with {
        $0.name = name
        $0.canSendMessage = name.isNotEmpty && $0.message.isNotEmpty
        $0.nameStatusMessage = nameStatusMessage(
          currentCount: name.count,
          limitCount: $0.nameCountLimit
        )
      }
      
    case .setMessage(let message):
      let message: String = message.count <= state.messageCountLimit ? message : state.message
      newState = state.with {
        $0.canSendMessage = $0.name.isNotEmpty && message.isNotEmpty
        $0.message = message
        $0.messageLimitGauge = percent(
          current: message.count,
          total: $0.messageCountLimit
        )
        $0.messageStatusMessage = messageStatusMessage(
          currentCount: message.count,
          limitCount: $0.messageCountLimit
        )
      }
      
    case .setEmojiId(let id):
      newState = state.with { $0.emojiId = id }
      
    case .setCountry(let country):
      newState = state.with { $0.selectedCountry = country }
      
    }
    return newState
  }
  
  // MARK: 📐 Formatting
  private func percent(current: Int, total: Int) -> Float { Float(current) / Float(total) }
  
  private func nameStatusMessage(currentCount: Int, limitCount: Int) -> NSAttributedString {
    let style: Style = currentCount > 0 ? Styles.normal : Styles.empty
    return "\(currentCount)/\(limitCount)".set(style: style)
  }
  
  private func messageStatusMessage(currentCount: Int, limitCount: Int) -> NSAttributedString {
    let currentStyle: Style
    let limitStyle: Style
    
    if currentCount == limitCount {
      currentStyle = Styles.fulfil
      limitStyle = Styles.fulfil
    } else if currentCount > 0 && currentCount < limitCount {
      currentStyle = Styles.normal
      limitStyle = Styles.empty
    } else {
      currentStyle = Styles.empty
      limitStyle = Styles.empty
    }
    return "\(currentCount)".set(style: currentStyle)
      + "/\(limitCount)".set(style: limitStyle)
  }
}
