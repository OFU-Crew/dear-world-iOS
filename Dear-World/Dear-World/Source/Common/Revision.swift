//
//  Revision.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/31.
//

import Foundation

@propertyWrapper
struct Revision<T>: Equatable {
    var projectedValue: UInt = 0
    var wrappedValue: T {
        didSet { projectedValue += 1 }
    }
}
extension Revision {
    static func == (lhs: Revision<T>, rhs: Revision<T>) -> Bool {
        let r1 = lhs.projectedValue == rhs.projectedValue
        return r1
    }
}
extension Revision where T: Equatable {
    static func == (lhs: Revision<T>, rhs: Revision<T>) -> Bool {
        let r1 = lhs.projectedValue == rhs.projectedValue
        let r2 = lhs.wrappedValue == rhs.wrappedValue
        return r1 && r2
    }
}
