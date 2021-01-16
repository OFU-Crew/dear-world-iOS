//
//  Completable.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/11.
//

import Foundation
import RxCocoa
import RxSwift

enum AssociatedKeys {
  static var expectedValue: String = "expectedValue"
}

protocol Promisable {
  associatedtype Expected
  var expected: PublishRelay<Expected> { get }
}
extension Promisable where Self: AnyObject {
  var expected: PublishRelay<Expected> {
    get {
      if let object: PublishRelay = objc_getAssociatedObject(self, &AssociatedKeys.expectedValue) as? PublishRelay<Expected> {
        return object
      } else {
        let object: PublishRelay = PublishRelay<Expected>()
        self.expected = object
        return object
      }
    }
    set { objc_setAssociatedObject(self, &AssociatedKeys.expectedValue, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }
}
