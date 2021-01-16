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
    case tapFilter
    case typeName(String)
    case typeMessage(String)
    case tapSendMessage
    case confirmSendAlert
    case confirmCancelAlert
    case countryDidChange(Model.Country)
  }
  
  enum Mutation {
    case setEmojiId(Int)
    case setEmojiURL(String)
    case setName(String)
    case setMessage(String)
    case setPresent(Bool)
    case setPresentSendAlert(Bool)
    case setPresentCancelAlert(Bool)
    case setPresentFilter(Bool)
    case setCountry(Model.Country)
    case setCountries([Model.Country])
  }
  
  struct State: Then {
    @Revision var isPresented: Bool = true
    @Revision var isPresentSendAlert: Bool = false
    @Revision var isPresentCancelAlert: Bool = false
    @Revision var isPresentFilter: Bool = false
    @Revision var selectedCountry: Model.Country = .wholeWorld
    @Revision var countries: [Model.Country] = []
    var emojiURL: String?
    var emojiIsLoading: Bool = true
    var canSendMessage: Bool = false
    @Revision var name: String = ""
    @Revision var message: String = ""
    var nameStatusMessage: NSAttributedString = NSAttributedString(string: "0/15")
    var messageLimitGauge: Float = 0.0
    var messageStatusMessage: NSAttributedString = NSAttributedString(string: "0/300")
    fileprivate var emojiId: Int?
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
      return .merge(
        Network.request(API.Countries())
          .filterNil()
          .map { .setCountries($0.countries) },
        .just(.setCountry(.current))
        )
      
    case .tapFilter:
      return .just(.setPresentFilter(true))
      
    case .tapClose:
      if currentState.name.isEmpty && currentState.message.isEmpty {
        return .just(.setPresent(false))
      }
      return .just(.setPresentCancelAlert(true))
      
    case .tapRefresh:
      return Network.request(Emoji.API.Random())
        .filterNil()
        .flatMap {
          Observable<Mutation>.from([
            .setEmojiId($0.id ?? 0),
            .setEmojiURL($0.imageURL)
          ])
        }
      
    case .typeName(let name):
      return .just(.setName(name))
      
    case .typeMessage(let message):
      return .just(.setMessage(message))
      
    case .tapSendMessage:
      return .just(.setPresentSendAlert(true))
      
    case .confirmSendAlert:
      guard let emojiId = currentState.emojiId,
            let countryCode = currentState.selectedCountry.code
      else { return .empty() }
      return .concat(
        Network.request(
          API.SendMessage(
            countryCode: countryCode,
            emojiId: emojiId,
            name: currentState.name,
            message: currentState.message
          )
        )
        .filterNil()
        .flatMap { _ in Observable<Mutation>.empty() },
        .just(.setPresent(false))
      )
      
    case .confirmCancelAlert:
      return .just(.setPresent(false))
      
    case .countryDidChange(let country):
      return .just(.setCountry(country))
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
      
    case .setPresentSendAlert(let isPresentSendAlert):
      newState = state.with {
        $0.isPresentSendAlert = isPresentSendAlert
      }
      
    case .setPresentCancelAlert(let isPresentCancelAlert):
      newState = state.with {
        $0.isPresentCancelAlert = isPresentCancelAlert
      }
      
    case .setName(let name):
      // FIXME: 🐛 네임 텍스트필드랑 불일치 문제 수정
      guard let name = name.substring(from: 0, length: state.nameCountLimit) else { return state }
      newState = state.with {
        $0.name = name
        $0.canSendMessage = name.isNotEmpty && $0.message.isNotEmpty
        $0.nameStatusMessage = nameStatusMessage(
          currentCount: name.count,
          limitCount: $0.nameCountLimit
        )
      }
      
    case .setMessage(let message):
      guard let message = message.substring(from: 0, length: state.messageCountLimit) else { return state }
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
      newState = state.with {
        $0.emojiId = id
      }
      
    case .setEmojiURL(let emojiURL):
      newState = state.with {
        $0.emojiURL = emojiURL
      }
      
    case .setCountry(let country):
      newState = state.with {
        $0.selectedCountry = country
      }
      
    case .setCountries(let countries):
      newState = state.with {
        $0.countries = countries
      }
      
    case .setPresentFilter(let isPresentFilter):
      newState = state.with {
        $0.isPresentFilter = isPresentFilter
      }
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

extension Message.Model.Country {
  static var current: Message.Model.Country {
    Message.Model.Country(
      code: Locale.current.regionCode,
      fullName: Locale.current.localizedString(forRegionCode: Locale.current.regionCode ?? "") ?? "",
      emojiUnicode: nil,
      imageURL: nil
    )
  }
}
