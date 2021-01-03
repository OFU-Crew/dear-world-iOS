//
//  NoticeBadge.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/03.
//

import UIKit

final class NoticeBadge: UILabel {
  
  var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
  
  // MARK: 🏁 Initialize
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawText(in rect: CGRect) {
    let insets: UIEdgeInsets = contentInsets
    super.drawText(in: rect.inset(by: insets))
  }
  
  override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + contentInsets.left + contentInsets.right,
                  height: size.height + contentInsets.top + contentInsets.bottom)
  }
  
  // MARK: 🎛 Setup
  private func setupUI() {
    self.do {
      $0.backgroundColor = .warmBlue
      $0.textColor = .illuminatingYellow
      $0.layer.cornerRadius = 5
      $0.layer.masksToBounds = true
    }
  }
}
