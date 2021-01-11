//
//  SelectItemReactor.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/11.
//

import Foundation
import ReactorKit

final class ItemBottomSheetReactor<Item: BottomSheetItem>: Reactor {
  
  enum Action {
    case tapClose
    case tapBackground
    case selectItem(at: Int)
  }
  
  enum Mutation {
    case setPresent(Bool)
    case setSelectedItem(Item)
  }
  
  struct State {
    @Revision var isPresent: Bool
    @Revision var selectedItem: Item?
    @Revision var items: [Item]
  }
  
  let initialState: State
  
  // MARK: 🏁 Initialize
  init(selectedItem: Item? = nil, items: [Item]) {
    initialState = State(
      isPresent: true,
      selectedItem: selectedItem,
      items: items
    )
  }
  
  // MARK: 🔫 Mutate
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .tapClose:
      return .just(.setPresent(false))
      
    case .tapBackground:
      return .just(.setPresent(false))
      
    case .selectItem(let index):
      let item: Item = currentState.items[index]
      return .just(.setSelectedItem(item))
    }
  }
  
  // MARK: ⚡️ Reduce
  func reduce(state: State, mutation: Mutation) -> State {
    var newState: State = state
    switch mutation {
    case .setPresent(let isPresent):
      newState.isPresent = isPresent
      
    case .setSelectedItem(let item):
      newState.selectedItem = item
    }
    return newState
  }
}
