//
//  CountryTableViewCell.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/26.
//

import RxCocoa
import RxSwift
import SnapKit
import SwiftRichString
import Then
import UIKit

final class RankerTableViewCell: UITableViewCell {
  
  // MARK: 🎨 Style
  enum Styles {
    static let topOf3: Style = Style {
      $0.font = UIFont.boldSystemFont(ofSize: 12)
      $0.color = UIColor.livelyBlue
    }
    static let normal: Style = Style {
        $0.font = UIFont.boldSystemFont(ofSize: 12)
        $0.color = UIColor.warmBlue
    }
  }
  
  // MARK: 🖼 UI
  let rankLabel: UILabel = UILabel()
  let countryFlagImageView: UIImageView = UIImageView()
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
    self.contentView.addSubview(countryFlagImageView)
    rankLabel.do {
      $0.font = .boldSystemFont(ofSize: 12)
    }
    rankLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.bottom.equalTo(countryFlagImageView)
    }
    countryFlagImageView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(14)
      $0.leading.equalToSuperview().inset(62)
      $0.width.equalTo(18)
      $0.height.equalTo(18)
    }
    
    self.contentView.addSubview(countryNameLabel)
    countryNameLabel.do {
      $0.font = .boldSystemFont(ofSize: 14)
      $0.textColor = .warmBlue
    }
    countryNameLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(14)
      $0.leading.equalTo(countryFlagImageView.snp.trailing).offset(10)
    }
    
    let messageImageView: UIImageView = UIImageView(image: UIImage(named: "message_default")!)
    self.contentView.addSubview(messageImageView)
    messageImageView.snp.makeConstraints {
      $0.leading.equalTo(countryNameLabel)
      $0.width.equalTo(18)
      $0.height.equalTo(12)
      $0.top.equalTo(countryNameLabel.snp.bottom).offset(10)
    }
    
    self.contentView.addSubview(messageCountLabel)
    messageCountLabel.do {
      $0.font = .systemFont(ofSize: 14)
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
    }
    cheerUpButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(20)
      $0.width.height.equalTo(32)
    }
  }
  
  // MARK: 🔩 Configuration
  func configure(with country: World.Model.Country, ranking: Int) {
    rankLabel.attributedText = formatRank(ranking)
    countryNameLabel.text = country.name
    if let url = URL(string: country.imageURL) {
      countryFlagImageView.kf.setImage(with: url)
    }
    messageCountLabel.text = country.status?.messageCount.formatted
  }
  
  private func formatRank(_ rank: Int) -> NSAttributedString {
    switch rank {
    case 1: return "\(rank)st".set(style: Styles.topOf3)
    case 2: return "\(rank)nd".set(style: Styles.topOf3)
    case 3: return "\(rank)rd".set(style: Styles.topOf3)
    default: return "\(rank)th".set(style: Styles.normal)
    }
  }
}
