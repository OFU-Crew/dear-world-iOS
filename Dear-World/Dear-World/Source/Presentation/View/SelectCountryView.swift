//
//  SelectCountryView.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/27.
//

import UIKit

final class SelectCountryView: UIView {
  
  // MARK: 🖼 UI
  let locationImageView: UIImageView = UIImageView()
  let titleLabel: UILabel = UILabel()
  let downArrowImageView: UIImageView = UIImageView()
  
  // MARK: 🏁 Initialize
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupUI()
  }
  
  // MARK: 📍 Setup
  private func setupUI() {
    self.backgroundColor = .grayWhite
    self.layer.cornerRadius = 7
    self.layer.masksToBounds = true
    
    addSubview(locationImageView)
    locationImageView.image = UIImage(named: "location")
    locationImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(24)
    }
    
    addSubview(titleLabel)
    titleLabel.do {
      $0.text = "----"
      $0.font = .boldSystemFont(ofSize: 14)
    }
    titleLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(locationImageView.snp.trailing).offset(4)
    }
    
    addSubview(downArrowImageView)
    downArrowImageView.image = UIImage(named: "down_arrow")
    downArrowImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(24)
    }
  }
}
