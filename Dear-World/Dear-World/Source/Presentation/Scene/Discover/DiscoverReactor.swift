//
//  DiscoverReactor.swift
//  Dear-World
//
//  Created by rookie.w on 2020/12/27.
//

import Foundation
import ReactorKit

class DiscoverReactor: Reactor {
    enum Action {
        case countryDidChanged(country: String)
    }
    enum Mutation {
        case setMessages(result: [MessageMock])
    }
    struct State {
        var messageCount: Int = 0
        //TODO: country는 String이 아니라 다른 값으로 저장
        var country: String = "Whole World"
        var messages: [MessageMock] = []
    }
    var initialState: State

    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .countryDidChanged :
            return APIMock().getMessages(page: 1)
                .map{Mutation.setMessages(result: $0)}
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState: State = state
        switch mutation {
        case let .setMessages(results) :
            newState.messages = results
        }
        return newState
    }
}
