//
//  AboutReactor.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/03.
//

import Foundation
import ReactorKit
import UIKit

final class AboutReactor: Reactor {
  
  enum Action {
    case initalize
    case tapClose
    case tapCrewInfo
    case tapNotice
    case tapVersion
  }
  
  enum Mutation {
    case setPresentCrewInfo(Bool)
    case setPresentNotice(Bool)
    case setPresentAppStore(Bool)
    case setWillDismiss(Bool)
    case setNoticeCount(Int)
    case setCurrentVersion(String)
  }
  
  struct State {
    @Revision var isPresentCrewInfo: Bool = false
    @Revision var isPresentNotice: Bool = false
    @Revision var isPresentAppStore: Bool = false
    @Revision var willDismiss: Bool = false
    var noticeCount: Int?
    var currentVersion: String?
  }
  
  var initialState: State
  
  // MARK: 🏁 Initialize
  init() {
    initialState = State()
  }
  
  // MARK: 🔫 Mutate
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .initalize:
      return .just(.setCurrentVersion(UIApplication.shared.version ?? ""))
      
    case .tapCrewInfo:
      return .just(.setPresentCrewInfo(true))
      
    case .tapNotice:
      return .just(.setPresentNotice(true))
      
    case .tapVersion:
      return .just(.setPresentAppStore(true))
      
    case .tapClose:
      return .just(.setWillDismiss(true))
    }
  }
  
  // MARK: ⚡️ Reduce
  func reduce(state: State, mutation: Mutation) -> State {
    var newState: State = state
    switch mutation {
    case .setPresentCrewInfo(let isPresentCrewInfo):
      newState.isPresentCrewInfo = isPresentCrewInfo
      
    case .setPresentNotice(let isPresentNotice):
      newState.isPresentNotice = isPresentNotice
      
    case .setPresentAppStore(let isPresentAppStore):
      newState.isPresentAppStore = isPresentAppStore
      
    case .setNoticeCount(let count):
      newState.noticeCount = count
      
    case .setCurrentVersion(let version):
      newState.currentVersion = version
      
    case .setWillDismiss(let willDismiss):
      newState.willDismiss = willDismiss
    }
    
    return newState
  }
}
