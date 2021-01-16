//
//  LikeButton.swift
//  Dear-World
//
//  Created by rookie.w on 2021/01/15.
//

import UIKit
import Lottie
import RxSwift

class LikeButton: UIView {
  enum Progress: CGFloat {
    case likeDefault = 30
    case unlikeDefault = 1
    case likeTouchEnd = 15
    case unlikeTouchEnd = 60
    
    func percent() -> CGFloat {
      self.rawValue / 60
    }
  }
  
  let disposeBag: DisposeBag = DisposeBag()
  let animationView: AnimationView = AnimationView(animation: Animation.named("heartfull"))
  var messageId: Int
  init(isLike: Bool, messageId: Int) {
    self.messageId = messageId
    super.init(frame: .null)
    setupUI(isLike: isLike)
    bind()
  }
  func setupUI(isLike: Bool) {
    self.addSubview(animationView)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.clipsToBounds = false
    animationView.snp.makeConstraints {
      $0.top.bottom.leading.trailing.equalToSuperview()
    }
    self.animationView.currentProgress = isLike ? Progress.likeDefault.percent() : Progress.unlikeDefault.percent()
  }
  func bind() {
    self.rx.tapGesture()
      .skip(1)
      .throttle(.milliseconds(1000), latest: false, scheduler: MainScheduler.instance)
      .flatMap { [weak self] _ -> Observable<Bool?> in
        guard let id = self?.messageId else {
          return Observable.just(false)
        }
        return Network.request(Message.API.Like(messageId: id))
          .map { $0?.isLiked }
      }
      .subscribe(onNext: { [weak self] isLike in
        self?.tap(isLike!)
      })
      .disposed(by: self.disposeBag)
  }
  @objc func tap(_ isLike: Bool) {
    animationView.pause()
    if isLike {
      self.animationView.play(fromProgress: Progress.unlikeDefault.percent(), toProgress: Progress.likeTouchEnd.percent())
    } else {
      self.animationView.play(fromProgress: Progress.likeDefault.percent(), toProgress: Progress.unlikeTouchEnd.percent())
    }
  }
  override init(frame: CGRect) {
    self.messageId = 0
    super.init(frame: frame)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
