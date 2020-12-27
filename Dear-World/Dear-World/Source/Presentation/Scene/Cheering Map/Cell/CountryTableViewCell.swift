//
//  CountryTableViewCell.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/26.
//

import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

final class CountryTableViewCell: UITableViewCell {
  
  // MARK: 🖼 UI
  let rankLabel: UILabel = UILabel()
  let countryFlagLabel: UILabel = UILabel()
  let countryNameLabel: UILabel = UILabel()
  let messageCountLabel: UILabel = UILabel()
  let cheerUpButton: CheerUpButton = CheerUpButton()
  
  let disposeBag: DisposeBag = DisposeBag()
  
  // MARK: 🏁 Initialize
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupUI()
  }
  
  // MARK: 📍 Setup
  private func setupUI() {
    self.contentView.addSubview(rankLabel)
    self.contentView.addSubview(countryFlagLabel)
    // FIXME: 🔮 더미 데이터 변경
    rankLabel.do {
      $0.font = .boldSystemFont(ofSize: 12)
      // FIXME: 🔮 더미 데이터 변경
      $0.text = "1st"
    }
    rankLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.bottom.equalTo(countryFlagLabel)
    }
    
    countryFlagLabel.do {
      $0.font = .boldSystemFont(ofSize: 14)
      // FIXME: 🔮 더미 데이터 변경
      $0.text = ["🇰🇷", "🇯🇵", "🇨🇦", "🇨🇮"].randomElement()!
    }
    countryFlagLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(14)
      $0.leading.equalToSuperview().inset(62)
    }
    
    self.contentView.addSubview(countryNameLabel)
    countryNameLabel.do {
      $0.font = .boldSystemFont(ofSize: 14)
      // FIXME: 🔮 더미 데이터 변경
      $0.text = "South Korea"
      $0.textColor = .warmBlue
    }
    countryNameLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(12)
      $0.leading.equalTo(countryFlagLabel.snp.trailing).offset(10)
    }
    
    let messageImageView: UIImageView = UIImageView(image: UIImage(named: "message_default")!)
    self.contentView.addSubview(messageImageView)
    messageImageView.snp.makeConstraints {
      $0.leading.equalTo(countryNameLabel)
      $0.width.equalTo(12)
      $0.height.equalTo(9)
      $0.top.equalTo(countryNameLabel.snp.bottom).offset(10)
    }
    
    self.contentView.addSubview(messageCountLabel)
    messageCountLabel.do {
      $0.font = .systemFont(ofSize: 14)
      // FIXME: 🔮 더미 데이터 변경
      $0.text = 952_682_252.formatted
    }
    messageCountLabel.snp.makeConstraints {
      $0.top.equalTo(countryNameLabel.snp.bottom).offset(5)
      $0.leading.equalTo(messageImageView.snp.trailing).offset(6)
      $0.bottom.equalToSuperview().inset(10)
      $0.centerY.equalTo(messageImageView)
    }
    
    self.contentView.addSubview(cheerUpButton)
    cheerUpButton.do {
      $0.layer.masksToBounds = true
      $0.layer.cornerRadius = 16
      // FIXME: 🔮 더미 데이터 변경
    }
    cheerUpButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(20)
      $0.width.height.equalTo(32)
    }
  }
  
  // MARK: 🔩 Configuration
  func configure() {
    // FIXME: 🔮 더미 데이터 변경
    countryFlagLabel.text = "🇰🇷"
    messageCountLabel.text = 952_682_252.formatted
  }
}
