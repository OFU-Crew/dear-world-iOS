//
//  BottomSheetItemCell.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/11.
//

import UIKit

final class BottomSheetItemCell: UITableViewCell {
  
  private let checkImageView: UIImageView = UIImageView()
  
  override var isSelected: Bool {
    didSet {
      if isSelected {
        textLabel?.textColor = .livelyBlue
        contentView.backgroundColor = .breathingWhite
      } else {
        textLabel?.textColor = .warmBlue
        contentView.backgroundColor = .white
      }
      checkImageView.isHidden = !isSelected
    }
  }
  
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
    checkImageView.do {
      $0.isHidden = !isSelected
      $0.image = UIImage(named: "check")
    }
    contentView.addSubview(checkImageView)
    checkImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(20)
      $0.width.equalTo(12)
      $0.height.equalTo(10)
    }
  }
  
  // MARK: 🔩 Configuration
  func configure(item: BottomSheetItem) {
    textLabel?.text = item.name
  }
}
