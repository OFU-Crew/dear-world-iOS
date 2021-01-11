//
//  BottomSheetItemCell.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/11.
//

import UIKit

protocol BottomSheetItem {
  var name: String { get }
  var imageURL: String? { get }
}
extension BottomSheetItem {
  var imageURL: String? { nil }
}

final class BottomSheetItemCell: UITableViewCell {
  
  // MARK: 🏁 Initialize
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: 🎛 Setup
  private func setupUI() {
    self.do {
      $0.backgroundColor = .white
      $0.textLabel?.textColor = .warmBlue
      $0.textLabel?.font = .systemFont(ofSize: 14)
    }
  }
  
  // MARK: 🔩 Configuration
  func configure(item: BottomSheetItem) {
    textLabel?.text = item.name
  }
}
