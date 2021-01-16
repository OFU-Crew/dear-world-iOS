//
//  MessageTableViewCell.swift
//  Dear-World
//
//  Created by rookie.w on 2020/12/26.
//

import Lottie
import RxCocoa
import RxSwift
import UIKit

final class MessageTableViewCell: UITableViewCell {
  private enum HeartProgress: CGFloat {
    case likeDefault = 30
    case unlikeDefault = 1
    case likeTouchEnd = 15
    case unlikeTouchEnd = 60
    
    func percent() -> CGFloat {
      self.rawValue / 60
    }
  }
  
  let disposeBag: DisposeBag = DisposeBag()
  // MARK: 🖼 UI
  let emojiImageView: UIImageView = UIImageView()
  let nameLabel: UILabel = UILabel()
  let countryLabel: UILabel = UILabel()
  let countryFlagImageView: UIImageView = UIImageView()
  let detailTextView: UITextView = UITextView()
  let shareButton: UIButton = UIButton()
  let likeView: AnimationView = AnimationView(animation: Animation.named("heart_fill"))
  let likeCountLabel: UILabel = UILabel()
  var likeCount: Int = 0 {
    didSet {
      self.likeCountLabel.text = "\(likeCount)"
    }
  }
  var isLike: Bool = false {
    didSet {
      self.likeView.currentProgress = isLike ? HeartProgress.likeDefault.percent() : HeartProgress.unlikeDefault.percent()
      self.likeCountLabel.textColor = isLike ? .loveRed : .grayWhite
    }
  }
  private var messageId: Int?
  
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
      $0.layer.cornerRadius = 20
      $0.layer.shadowColor = UIColor.black.cgColor
    }
    self.contentView.addSubview(mainView)
    mainView.snp.makeConstraints {
      $0.top.equalTo(headerView.snp.bottom)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview()
    }
    
    let emojiBackgroundView: UIImageView = UIImageView().then {
      $0.image = UIImage(named: "emojiBox")
    }
    mainView.addSubview(emojiBackgroundView)
    emojiBackgroundView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(30)
      $0.height.width.equalTo(40)
    }
    emojiImageView.do {
      $0.layer.shadowOffset = CGSize(width: 3, height: 5)
      $0.layer.shadowOpacity = 0.2
      $0.layer.shadowColor = UIColor.black.cgColor
    }
    mainView.addSubview(emojiImageView)
    emojiImageView.snp.makeConstraints {
      $0.size.equalTo(20)
      $0.center.equalTo(emojiBackgroundView)
    }
    
    self.nameLabel.do {
      $0.text = "Judy"
      $0.font = .boldSystemFont(ofSize: 16)
      $0.textColor = .warmBlue
    }
    mainView.addSubview(self.nameLabel)
    self.nameLabel.snp.makeConstraints {
      $0.top.equalTo(emojiBackgroundView.snp.top)
      $0.leading.equalTo(emojiBackgroundView.snp.trailing).offset(10)
      $0.trailing.lessThanOrEqualToSuperview()
    }
    mainView.addSubview(countryFlagImageView)
    countryFlagImageView.snp.makeConstraints {
      $0.bottom.equalTo(emojiBackgroundView.snp.bottom)
      $0.leading.equalTo(emojiBackgroundView.snp.trailing).offset(10)
      $0.width.height.equalTo(18)
    }
    self.countryLabel.do {
      $0.text = "South Korea"
      $0.font = .boldSystemFont(ofSize: 12)
      $0.textColor = .nightBlue
    }
    mainView.addSubview(self.countryLabel)
    self.countryLabel.snp.makeConstraints {
      $0.centerY.equalTo(countryFlagImageView)
      $0.leading.equalTo(countryFlagImageView.snp.trailing).offset(5)
      $0.trailing.lessThanOrEqualToSuperview()
    }
    
    self.detailTextView.do {
      $0.text = "Hello world, dont worry because you’re strong enough to overcome this corona blue. At the end of the day, trust yourself. more"
      $0.font = .systemFont(ofSize: 12)
      $0.textColor = .warmBlue
      $0.textContainerInset = .zero
      $0.isScrollEnabled = false
      $0.isEditable = false
    }
    mainView.addSubview(self.detailTextView)
    self.detailTextView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(30)
      $0.top.equalTo(emojiBackgroundView.snp.bottom).offset(10)
    }
    
    self.likeView.do {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.clipsToBounds = false
    }
    mainView.addSubview(likeView)
    likeView.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.top.equalTo(detailTextView.snp.bottom).offset(7)
      $0.bottom.equalToSuperview().inset(13)
      $0.height.equalTo(40)
      $0.width.equalTo(40)
    }
    
    self.likeCountLabel.do {
      $0.font = .boldSystemFont(ofSize: 12)
      $0.textColor = .grayWhite
    }
    mainView.addSubview(self.likeCountLabel)
    self.likeCountLabel.snp.makeConstraints {
      $0.centerY.equalTo(likeView.snp.centerY)
      $0.height.equalTo(17)
      $0.leading.equalTo(likeView.snp.trailing).offset(-5)
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
  
  private func bind() {
    self.likeView
      .rx.tapGesture()
      .debug()
      .skip(1)
      .throttle(.milliseconds(1000), latest: false, scheduler: MainScheduler.instance)
      .flatMap { [weak self] _ -> Observable<Bool?> in
        guard let id = self?.messageId else {
          return Observable.just(false)
        }
        return Network.request(Message.API.Like(messageId: id))
          .map { $0?.isLiked }
      }
      .filterNil()
      .subscribe(onNext: { [weak self] isLike in
        guard let likeView = self?.likeView else { return }
        likeView.pause()
        if !isLike {
          self?.likeCount -= 1
          self?.likeCountLabel.textColor = .grayWhite
        }
        likeView.play(
          // TODO : 각 상황에 대한 값들을 enum으로 정의할것
          fromProgress: isLike ? HeartProgress.unlikeDefault.percent() : HeartProgress.likeDefault.percent(),
          toProgress: isLike ? HeartProgress.likeTouchEnd.percent() : HeartProgress.unlikeTouchEnd.percent()) { completed in
          if completed && isLike{
            self?.likeCount += 1
            self?.likeCountLabel.textColor = .loveRed
          }
        }
      })
      .disposed(by: self.disposeBag)
  }
  
  func configure(_ message: Message.Model.Message) {
    nameLabel.text = message.user.nickname
    detailTextView.text = message.content
    likeCount = message.likeCount
    isLike = message.isLiked
    countryLabel.text = message.user.country.fullName
    if let emojiImageURL: URL = URL(string: message.user.emoji.imageURL) {
      emojiImageView.kf.setImage(with: emojiImageURL)
    }
    if let countryImageURL: URL = URL(string: message.user.country.imageURL) {
      countryFlagImageView.kf.setImage(with: countryImageURL)
    }
    messageId = message.id
  }
}
