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
  
  enum Action {
    case tapClose
    case tapRefresh
    case typeName(String)
    case typeMessage(String)
    case tapSendMessage
  }
  
  enum Mutation {
    case setEmoji(String)
    case setName(String)
    case setMessage(String)
    case setPresent(Bool)
  }
  
  struct State: Then {
    var isPresented: Bool = true
    var emoji: String = "👽"
    var canSendMessage: Bool = false
    var name: String = ""
    var message: String = ""
    var nameStatusMessage: NSAttributedString = NSAttributedString(string: "0/15")
    var messageLimitGauge: Float = 0.0
    var messageStatusMessage: NSAttributedString = NSAttributedString(string: "0/300")
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
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .tapClose:
      return .just(.setPresent(false))
    
    case .tapRefresh:
      return Network.request(Emoji.API.Random())
          .filterNil()
          .map { .setEmoji($0.unicode) }
      
    case .typeName(let name):
      return .just(.setName(name))
      
    case .typeMessage(let message):
      return .just(.setMessage(message))
      
    case .tapSendMessage:
      let api: Message.API.SendMessage = Message.API.SendMessage(
        countryCode: "KR",
        emojiId: currentState.emojiId,
        name: currentState.name,
        message: currentState.message
      )
      return Network.request(api)
        .filterNil()
        .map { _ in .setMessage("완료") }
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState: State
    switch mutation {
    case .setPresent(let isPresented):
      newState = state.with {
        $0.isPresented = isPresented
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
    }
    return newState
  }
  
  private func percent(current: Int, total: Int) -> Float {
    return Float(current) / Float(total)
  }
  
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
