//
//  MessageTableViewCell.swift
//  Dear-World
//
//  Created by rookie.w on 2020/12/26.
//

import RxCocoa
import RxSwift
import UIKit

final class MessageTableViewCell: UITableViewCell {
  let disposeBag: DisposeBag = DisposeBag()
  // MARK: 🖼 UI
  let emojiLabel: UILabel = UILabel()
  let nameLabel: UILabel = UILabel()
  let countryLabel: UILabel = UILabel()
  let detailTextView: UITextView = UITextView()
  let likeView: UIImageView = UIImageView()
  let likeCountLabel: UILabel = UILabel()
  let shareButton: UIButton = UIButton()
  var likeCount: Int = 0 {
    didSet {
      self.likeCountLabel.text = "\(likeCount)"
    }
  }
  var messageId: Int?
  
  // MARK: 🏁 Initialize
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
    bind()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
    bind()
  }
  
  // MARK: 🎛 Setup
  private func setupUI() {
    self.do {
      $0.selectionStyle = .none
      $0.backgroundColor = .breathingWhite
    }
    let headerView: UIView = UIView()
    self.addSubview(headerView)
    headerView.snp.makeConstraints {
      $0.height.equalTo(20)
      $0.top.trailing.leading.equalToSuperview()
    }
    let mainView: UIView = UIView().then {
      $0.backgroundColor = .white
      $0.layer.masksToBounds = true
      $0.layer.cornerRadius = 20
    }
    self.addSubview(mainView)
    mainView.snp.makeConstraints {
      $0.top.equalTo(headerView.snp.bottom)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview()
    }
    
    let emojiView: UIImageView = UIImageView().then {
      $0.image = UIImage(named: "emojiBox")
    }
    mainView.addSubview(emojiView)
    emojiView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(30)
      $0.height.width.equalTo(40)
    }
    
    self.emojiLabel.do {
      $0.text = "🎅🏻"
      $0.font = .systemFont(ofSize: 14)
      $0.textAlignment = .center
    }
    mainView.addSubview(self.emojiLabel)
    self.emojiLabel.snp.makeConstraints {
      $0.size.equalTo(20)
      $0.center.equalTo(emojiView)
    }
    
    self.nameLabel.do {
      $0.text = "Judy"
      $0.font = .boldSystemFont(ofSize: 16)
      $0.textColor = .warmBlue
    }
    mainView.addSubview(self.nameLabel)
    self.nameLabel.snp.makeConstraints {
      $0.top.equalTo(emojiView.snp.top)
      $0.leading.equalTo(emojiView.snp.trailing).offset(10)
      $0.trailing.greaterThanOrEqualToSuperview().inset(30)
    }
    
    self.countryLabel.do {
      $0.text = "🇰🇷 South Korea"
      $0.font = .boldSystemFont(ofSize: 12)
      $0.textColor = .grayWhite
    }
    mainView.addSubview(self.countryLabel)
    self.countryLabel.snp.makeConstraints {
      $0.bottom.equalTo(emojiView.snp.bottom)
      $0.leading.equalTo(emojiView.snp.trailing).offset(10)
      $0.trailing.greaterThanOrEqualToSuperview().inset(30)
    }
    
    self.detailTextView.do {
      $0.text = "Hello world, dont worry because you’re strong enough to overcome this corona blue. At the end of the day, trust yourself. more"
      $0.font = .systemFont(ofSize: 12)
      $0.textColor = .black
      $0.textContainerInset = .zero
      $0.isScrollEnabled = false
      $0.isEditable = false
    }
    mainView.addSubview(self.detailTextView)
    self.detailTextView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(30)
      $0.top.equalTo(emojiView.snp.bottom).offset(10)
    }
    
    self.likeView.do {
      $0.image = UIImage(named: "heart")
    }
    mainView.addSubview(likeView)
    self.likeView.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(30)
      $0.top.equalTo(detailTextView.snp.bottom).offset(19)
      $0.bottom.equalToSuperview().inset(24)
      $0.height.equalTo(17)
      $0.width.equalTo(20)
    }
    
    self.likeCountLabel.do {
      $0.font = .boldSystemFont(ofSize: 12)
      $0.textColor = .grayWhite
    }
    mainView.addSubview(self.likeCountLabel)
    self.likeCountLabel.snp.makeConstraints {
      $0.centerY.equalTo(likeView.snp.centerY)
      $0.height.equalTo(14)
      $0.leading.equalTo(likeView.snp.trailing).offset(5)
    }
    
    self.shareButton.do {
      $0.backgroundColor = .refreshingWhite
      $0.layer.masksToBounds = true
      $0.layer.cornerRadius = 8
      $0.setImage(UIImage(named: "share"), for: .normal)
      $0.setImage(UIImage(named: "share_press"), for: .highlighted)
      $0.tintColor = .warmBlue
    }
    mainView.addSubview(shareButton)
    shareButton.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(30)
      $0.bottom.equalToSuperview().inset(25)
      $0.width.equalTo(30)
      $0.height.equalTo(25)
    }
  }
  
  // MARK: 🔗 Bind
  func bind() {
    self.shareButton
      .rx.tap
      .bind{ _ in print("!") }
    
    self.likeView
      .rx.tapGesture()
      .flatMap {[weak self] _ -> Observable<Bool?> in
        guard let id = self?.messageId else {
          return Observable.just(false)
        }
        return Network.request(Message.API.Like(messageId: id))
          .map {$0?.like}
      }
      .filter {$0 == true}
      .bind {[weak self] _ in
        self?.likeView.image = UIImage(named: "heart")
        self?.likeCount += 1
      }
      .disposed(by: self.disposeBag)
//      .bind(to: self.likeCountLabel.rx.text)
//      .disposed(by: self.disposeBag)
  }
}
