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
  let emojiImageView: UIImageView = UIImageView()
  let nameLabel: UILabel = UILabel()
  let countryLabel: UILabel = UILabel()
  let countryFlagImageView: UIImageView = UIImageView()
  let detailTextView: UITextView = UITextView()
  let likeView: UIImageView = UIImageView()
  let likeCountLabel: UILabel = UILabel()
  let shareButton: UIButton = UIButton()
  var likeCount: Int = 0 {
    didSet {
      self.likeCountLabel.text = "\(likeCount)"
    }
  }
  var isLike: Bool = false {
    //FIXME : 내려올 때 isLiked가 항상 false로 내려옴
    didSet {
      self.likeView.image = isLike ? UIImage(named: "heart_liked") : UIImage(named: "heart")
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
    self.contentView.addSubview(headerView)
    headerView.snp.makeConstraints {
      $0.height.equalTo(20)
      $0.top.trailing.leading.equalToSuperview()
    }
    let mainView: UIView = UIView().then {
      $0.backgroundColor = .white
      $0.layer.masksToBounds = true
      $0.layer.cornerRadius = 20
    }
    self.contentView.addSubview(mainView)
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
    
    mainView.addSubview(emojiImageView)
    emojiImageView.snp.makeConstraints {
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
    
    mainView.addSubview(countryFlagImageView)
    countryFlagImageView.snp.makeConstraints {
      $0.bottom.equalTo(emojiView.snp.bottom)
      $0.leading.equalTo(emojiView.snp.trailing).offset(10)
      $0.width.height.equalTo(18)
    }
    self.countryLabel.do {
      $0.text = "South Korea"
      $0.font = .boldSystemFont(ofSize: 12)
      $0.textColor = .grayWhite
    }
    mainView.addSubview(self.countryLabel)
    self.countryLabel.snp.makeConstraints {
      $0.centerY.equalTo(countryFlagImageView)
      $0.leading.equalTo(countryFlagImageView.snp.trailing).offset(10)
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
  private func bind() {
    self.likeView
      .rx.tapGesture()
      .debug()
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .flatMap { [weak self] _ -> Observable<Bool?> in
        guard let id = self?.messageId else {
          return Observable.just(false)
        }
        return Network.request(Message.API.Like(messageId: id))
          .map { $0?.isLiked }
      }
      .filterNil()
      .subscribe (onNext: {[weak self] isLike in
        self?.isLike = isLike
        self?.likeCount += (isLike ? 1 : -1)
      })
      .disposed(by: self.disposeBag)
  }
}
