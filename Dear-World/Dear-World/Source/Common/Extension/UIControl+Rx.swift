//
//  UIControl+Rx.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/27.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIControl {
  var state: Observable<UIControl.State> {
    base.rx.observe(UIControl.State.self, "state")
      .filterNil()
  }
}
