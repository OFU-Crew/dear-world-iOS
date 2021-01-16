//
//  BottomSheetItem.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/12.
//

import Foundation

protocol BottomSheetItem {
  var name: String { get }
  var imageURL: String? { get }
}
extension BottomSheetItem {
  var imageURL: String? { nil }
}

extension Message.Model.Country: BottomSheetItem {
  var name: String { fullName }
}

extension Message.Model.Sort: BottomSheetItem {
  var name: String { title }
}
