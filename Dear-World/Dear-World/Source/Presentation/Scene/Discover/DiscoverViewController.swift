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
  private let messageTableView: UITableView = UITableView()
  private let aboutButton: UIButton = UIButton()
  private var messages: [Message.Model.Message] = []
//  private let outerScrollView: UIScrollView = UIScrollView()
  private var scrollOuter: Bool = true
  private var scrollRecentConvertTime: Date = Date()
  
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
//    self.outerScrollView.do {
//      $0.isScrollEnabled = true
//      $0.showsVerticalScrollIndicator = false
//      $0.contentSize.height = self.view.frame.height + 264
//      $0.delegate = self
//    }
//    self.view.addSubview(outerScrollView)
//    self.outerScrollView.snp.makeConstraints {
//      $0.top.bottom.leading.trailing.equalToSuperview()
//    }
    messageTableView.do {
      $0.backgroundColor = .breathingWhite
    }
    self.view.addSubview(self.messageTableView)
    self.messageTableView.snp.makeConstraints {
//      $0.top.equalTo(filterContainerView.snp.bottom).offset(30)
//      $0.trailing.leading.equalTo(self.view.safeAreaLayoutGuide).inset(20)
//      $0.bottom.equalTo(self.outerScrollView.frameLayoutGuide.snp.bottom)
      $0.top.bottom.trailing.leading.equalToSuperview()
    }
    
    let headerView: UIView = UIView().then {
      $0.backgroundColor = .red
    }
    self.messageTableView.tableHeaderView = headerView
    headerView.snp.makeConstraints {
      $0.height.equalTo(100 + 44)
    }
    headerView.addSubview(self.messageCountBadgeView)
    messageCountBadgeView.snp.makeConstraints {
      $0.centerX.equalTo(view.snp.centerX)
      $0.top.equalToSuperview().inset(16)
    }
    headerView.addSubview(self.filterContainerView)
    self.filterContainerView.snp.makeConstraints {
      $0.leading.equalTo(self.view.snp.leading).offset(20)
      $0.top.equalTo(messageCountBadgeView.snp.bottom).offset(30)
//      $0.top.equalTo(self.messageCountBadgeView.snp.bottom).offset(30)
      $0.height.equalTo(26)
    }
    
    countryLabel.do {
      $0.font = .boldSystemFont(ofSize: 16)
      $0.textColor = .warmBlue
      $0.text = "Whole world"
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
      $0.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
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
    }
    
//    if let layout: UICollectionViewFlowLayout = self.messageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//      layout.minimumLineSpacing = 20
//    }
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
      .map(\.isRefreshing)
      .distinctUntilChanged()
      .filter { !$0 }
      .bind {[weak self] _ in
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
      .bind { _ in
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
      .map { Reactor.Action.loadMore }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.filterContainerView
      .rx.tapGesture()
      .skip(1)
      .flatMap { [weak self] _ -> Observable<Message.Model.Country> in
        guard let self = self else { return Observable.just(Message.Model.Country(code: "", fullName: "", emojiUnicode: "")) }
        return CountrySelectController.selectCountry(presenting: self, disposeBag: self.disposeBag, selected: self.reactor?.currentState.selectedCountry)
      }
      .map { Reactor.Action.countryDidChanged(country: $0) }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.aboutButton.rx.tap
      .map { Reactor.Action.tapAbout }
      .bind(to: reactor.action)
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
  }
}
extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageTableViewCell else { return UITableViewCell() }
    cell.do {
      $0.nameLabel.text = self.messages[indexPath.row].user.nickname
      $0.emojiLabel.text = self.messages[indexPath.row].user.emoji.unicode
      $0.detailTextView.text = self.messages[indexPath.row].content
      $0.likeCountLabel.text = "\(self.messages[indexPath.row].likeCount)"
      $0.countryLabel.text = self.messages[indexPath.row].user.country.emojiUnicode
    }
    bindShareButton(button: cell.shareButton)
    if reactor?.currentState.currentPage == 1 {
      self.animate(
        view: cell,
        alpha: 0.3,
        length: 50,
        duration: 0.5,
        delay: Double(indexPath.row)
      )
    }
    return cell
  }
  
  
//  func collectionView(
//    _ collectionView: UICollectionView,
//    layout collectionViewLayout: UICollectionViewLayout,
//    sizeForItemAt indexPath: IndexPath
//  ) -> CGSize {
//    return CGSize(width: collectionView.frame.width, height: 192)
//  }
  
  private func bindShareButton(button: UIButton) {
    button
      .rx.tap
      .bind {
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
