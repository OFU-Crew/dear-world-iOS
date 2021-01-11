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
  var expectedValue: PublishRelay<Expected> { get }
}
extension Promisable where Self: AnyObject {
  var expectedValue: PublishRelay<Expected> {
    get {
      if let object: PublishRelay = objc_getAssociatedObject(self, &AssociatedKeys.expectedValue) as? PublishRelay<Expected> {
        return object
      } else {
        let object: PublishRelay = PublishRelay<Expected>()
        self.expectedValue = object
        return object
      }
    }
    set { objc_setAssociatedObject(self, &AssociatedKeys.expectedValue, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }
}
