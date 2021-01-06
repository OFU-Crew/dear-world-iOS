//
//  DiscoverViewController.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/25.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

final class DiscoverViewController: UIViewController, View {
  
  // MARK: 🖼 UI
  private let messageCountBadgeView: MessageCountBadgeView = MessageCountBadgeView()
  private let filterContainerView: UIView = UIView()
  private let countryLabel: UILabel = UILabel()
  private let messageTableView: UITableView = UITableView(frame: .null, style: .grouped)
  private let aboutButton: UIButton = UIButton()
  private var messages: [Message.Model.Message] = []
  
  var disposeBag: DisposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupTableView()
    startInitAnimation()
  }
  
  private func startInitAnimation() {
    animate(view: messageCountBadgeView, alpha: 0.4, length: 20, duration: 0.4)
    animate(view: filterContainerView, alpha: 0.4, length: 20, duration: 0.4)
  }
  
  private func animate(view: UIView, alpha: CGFloat, length: CGFloat, duration: Double, delay: Double = 0) {
    view.alpha = alpha
    view.frame.origin.y += length
    UIView.animate(withDuration: duration) {
      view.alpha = 1
      view.frame.origin.y -= length
    }
  }
  
  // MARK: 🎛 Setup
  private func setupUI() {
    self.view.backgroundColor = .breathingWhite
    
    messageTableView.do {
      $0.backgroundColor = .breathingWhite
    }
    self.view.addSubview(self.messageTableView)
    self.messageTableView.snp.makeConstraints {
      $0.top.bottom.trailing.leading.equalToSuperview()
    }
  }
  
  private func setupTableView() {
    self.messageTableView.do {
      $0.register(MessageTableViewCell.self, forCellReuseIdentifier: "MessageCell")
      $0.delegate = self
      $0.dataSource = self
      $0.showsVerticalScrollIndicator = false
      $0.separatorStyle = .none
      $0.estimatedRowHeight = 200
      $0.rowHeight = UITableView.automaticDimension
      $0.sectionHeaderHeight = 150
      $0.tableHeaderView = nil
      $0.allowsSelection = false
    }
  }
  
  // MARK: 🔗 Bind
  func bind(reactor: DiscoverReactor) {
    _ = AllCountries.shared
    reactor.action.onNext(.countryDidChanged(country: Message.Model.Country(
                                              code: nil,
                                              fullName: "Whole World",
                                              emojiUnicode: "🍎"
    )))
    
    reactor.state
      .map(\.messageCount)
      .subscribe { [weak self] count in
        self?.messageCountBadgeView.count = count
      }
      .disposed(by: self.disposeBag)
    
    reactor.state
      .distinctUntilChanged(\.$messages)
      .map(\.messages)
      .subscribe(onNext: {[weak self] mess in
        self?.messages = mess.messages
        self?.messageTableView.reloadData()
      })
      .disposed(by: self.disposeBag)
    
    reactor.state
      .distinctUntilChanged(\.$isPresentAboutPage)
      .map { $0.isPresentAboutPage }
      .subscribe(onNext: { [weak self] in
        let viewController = AboutViewController().then {
          $0.reactor = AboutReactor()
        }
        let naviController = UINavigationController(rootViewController: viewController).then {
          $0.modalPresentationStyle = .fullScreen
        }
        self?.present(naviController, animated: false, completion: nil)
      })
      .disposed(by: self.disposeBag)
    
    reactor.state
      .map(\.isRefreshing)
      .distinctUntilChanged()
      .filter { !$0 }
      .subscribe {[weak self] _ in
        self?.messageTableView.refreshControl?.endRefreshing()
      }
      .disposed(by: self.disposeBag)
    
    reactor.state
      .distinctUntilChanged(\.$selectedCountry)
      .map(\.selectedCountry)
      .map{$0?.fullName}
      .bind(to: self.countryLabel.rx.text)
      .disposed(by: self.disposeBag)
    
    reactor.state
      .distinctUntilChanged(\.$selectedCountry)
      .map(\.selectedCountry)
      .subscribe { _ in
        self.messageTableView.setContentOffset(.zero, animated: false)
      }
      .disposed(by: self.disposeBag)
    
    self.messageTableView
      .refreshControl?.rx
      .controlEvent(.valueChanged)
      .map { Reactor.Action.refresh }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.messageTableView
      .rx.isReachedBottom
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { Reactor.Action.loadMore }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.filterContainerView
      .rx.tapGesture()
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .skip(1)
      .flatMap { [weak self] _ -> Observable<Message.Model.Country> in
        guard let self = self else { return Observable.just(Message.Model.Country(code: "", fullName: "", emojiUnicode: "")) }
        return CountrySelectController.selectCountry(presenting: self, disposeBag: self.disposeBag, selected: self.reactor?.currentState.selectedCountry)
      }
      .map { Reactor.Action.countryDidChanged(country: $0) }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)

    self.aboutButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { Reactor.Action.tapAbout }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
  }
}
extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return makeHeaderView()
  }
  private func makeHeaderView() -> UIView {
    let headerView: UIView = UIView()
    headerView.backgroundColor = .breathingWhite
    
    headerView.addSubview(self.messageCountBadgeView)
    messageCountBadgeView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().inset(16)
    }
    headerView.addSubview(self.filterContainerView)
    self.filterContainerView.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.top.equalTo(messageCountBadgeView.snp.bottom).offset(30)
      $0.height.equalTo(26)
    }
    countryLabel.do {
      $0.font = .boldSystemFont(ofSize: 16)
      $0.textColor = .warmBlue
    }
    filterContainerView.addSubview(countryLabel)
    countryLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(filterContainerView.snp.leading)
    }
    
    let select: UIImageView = UIImageView().then {
      $0.image = UIImage(named: "select")
    }
    filterContainerView.addSubview(select)
    select.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.width.equalTo(14)
      $0.height.equalTo(8)
      $0.trailing.equalTo(filterContainerView.snp.trailing)
      $0.leading.equalTo(countryLabel.snp.trailing).offset(5)
    }
    headerView.addSubview(aboutButton)
    aboutButton.do {
      $0.setImage(UIImage(named: "about"), for: .normal)
    }
    aboutButton.snp.makeConstraints {
      $0.size.equalTo(20)
      $0.top.equalToSuperview().inset(20)
      $0.trailing.equalToSuperview().inset(20)
    }
    return headerView
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageTableViewCell else { return UITableViewCell() }
    cell.do {
      $0.nameLabel.text = self.messages[indexPath.row].user.nickname
      $0.emojiLabel.text = self.messages[indexPath.row].user.emoji.unicode
      $0.detailTextView.text = self.messages[indexPath.row].content
      $0.likeCount = self.messages[indexPath.row].likeCount
      $0.isLike = self.messages[indexPath.row].isLiked
      $0.countryLabel.text = self.messages[indexPath.row].user.country.emojiUnicode
      $0.messageId = self.messages[indexPath.row].id
    }
    bindShareButton(button: cell.shareButton)
    return cell
  }

  private func bindShareButton(button: UIButton) {
    button
      .rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .subscribe {
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: ["hi"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true)
      }
      .disposed(by: self.disposeBag)
  }
}

extension Reactive where Base: UIScrollView {
  public var isReachedBottom: ControlEvent<Void> {
    let source = self.contentOffset
      .filter { [weak base = self.base] offset in
        guard let base = base else { return false }
        return base.isReachedBottom(withTolerance: base.frame.height / 2)
      }
      .map { _ in }
    return ControlEvent(events: source)
  }
}

extension UIScrollView {
  func isReachedBottom(withTolerance tolerance: CGFloat = 0) -> Bool {
    guard self.frame.height > 0 else { return false }
    guard self.contentSize.height > 0 else { return false }
    let contentOffsetBottom = self.contentOffset.y + self.frame.height
    return contentOffsetBottom >= self.contentSize.height - tolerance
  }
}
