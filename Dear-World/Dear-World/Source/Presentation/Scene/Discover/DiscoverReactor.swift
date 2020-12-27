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
        case refresh
        case loadMore
    }
    enum Mutation {
        case setMessages(result: [MessageMock])
        case setRefreshing(Bool)
        case addMessages(result: [MessageMock])
        case setCountry(country: String)
//        case setLoading(Bool)
    }
    struct State {
        var messageCount: Int = 0
        //TODO: country는 String이 아니라 다른 값으로 저장
        var country: String = "Whole World"
        var messages: [MessageMock] = []
        var isRefreshing: Bool = false
        var isLoading: Bool = false
    }
    var initialState: State

    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .countryDidChanged(country):
            return Observable<Mutation>.merge(
                APIMock().getMessages(page: 1, country: country)
                    .map { Mutation.setMessages(result: $0)},
                Observable.just(Mutation.setCountry(country: country))
            )
        case .refresh:
            return Observable<Mutation>.concat([
                Observable.just(Mutation.setRefreshing(true)),
                APIMock().getMessages(page: 1, country: currentState.country)
                .map { Mutation.setMessages(result: $0) },
                Observable.just(Mutation.setRefreshing(false))
            ])
        case .loadMore:
            return Observable<Mutation>.concat([
                APIMock().getMessages(page: 2, country: currentState.country)
                    .map { Mutation.addMessages(result: $0) }
            ])
//        case .countryTouched:
//            return
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState: State = state
        switch mutation {
        case let .setMessages(results):
            newState.messages = results
        case let .setRefreshing(flag):
            newState.isRefreshing = flag
        case let .addMessages(result: results):
            newState.messages = state.messages + results
        case let .setCountry(country: country):
            newState.country = country
        }
        return newState
    }
}
