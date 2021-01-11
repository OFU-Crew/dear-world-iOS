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
        lhs.projectedValue == rhs.projectedValue
    }
}
extension Revision where T: Equatable {
    static func == (lhs: Revision<T>, rhs: Revision<T>) -> Bool {
      let r1: Bool = lhs.projectedValue == rhs.projectedValue
      let r2: Bool = lhs.wrappedValue == rhs.wrappedValue
        return r1 && r2
    }
}
