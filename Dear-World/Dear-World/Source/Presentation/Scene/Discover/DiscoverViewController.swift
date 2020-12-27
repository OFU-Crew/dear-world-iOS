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
    private let messageCountBadgeView: MessageCountBadgeView = MessageCountBadgeView()
    private let filterContainerView: UIView = UIView()
    private let countryLabel: UILabel = UILabel()
    private let messageCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var messages: [MessageMock] = []
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .breathingWhite
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        self.reactor = DiscoverReactor()
    }
    func bind(reactor: DiscoverReactor) {
        
        //TODO: RxCocoa import되면 Binder extension 만들 것
        reactor.state
            .map(\.messageCount)
            .subscribe { [weak self] count in
                self?.messageCountBadgeView.count = count
            }
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map(\.messages)
            .subscribe(onNext: {[weak self] mess in
                self?.messages = mess
                self?.messageCollectionView.reloadData()
            })
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map(\.isRefreshing)
            .filter { !$0 }
            .bind {[weak self] _ in
                self?.messageCollectionView.refreshControl?.endRefreshing()
            }
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map(\.country)
            .bind(to: self.countryLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        self.countryLabel
            .rx.observe(String.self, "text")
            .filter { $0 != nil }
            .map { $0! }
            .distinctUntilChanged()
            .map { Reactor.Action.countryDidChanged(country: $0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.messageCollectionView
            .refreshControl?.rx
            .controlEvent(.valueChanged)
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.messageCollectionView
            .rx.isReachedBottom
            .map { Reactor.Action.loadMore }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.filterContainerView
            .rx.tapGesture()
            .skip(1)
            .flatMap { [weak self] _ -> Observable<String> in
                guard let self = self else { return Observable.just("") }
                return CountrySelectController.selectCountry(presenting: self, disposeBag: self.disposeBag)
            }
            .map { Reactor.Action.countryDidChanged(country: $0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func setupUI() {
        self.view.addSubview(self.messageCountBadgeView)
        
        self.view.addSubview(self.filterContainerView)
        self.filterContainerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.messageCountBadgeView.snp.bottom).offset(30)
            $0.height.equalTo(26)
        }
        
        countryLabel.do {
            $0.font = .boldSystemFont(ofSize: 22)
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
        
        messageCollectionView.backgroundColor = .breathingWhite
        self.view.addSubview(self.messageCollectionView)
        self.messageCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterContainerView.snp.bottom).offset(30)
            $0.trailing.leading.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.equalTo(300)
        }
    }
    
    private func setupCollectionView() {
        self.messageCollectionView.register(MessageTableViewCell.self, forCellWithReuseIdentifier: "messageCell")
        self.messageCollectionView.delegate = self
        self.messageCollectionView.dataSource = self
        self.messageCollectionView.refreshControl = UIRefreshControl()
        
        let layout: UICollectionViewFlowLayout = self.messageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 20
    }
}
extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCell", for: indexPath) as? MessageTableViewCell else {return UICollectionViewCell()}
        cell.nameLabel.text = self.messages[indexPath.row].name
        cell.emojiLabel.text = self.messages[indexPath.row].emoji
        cell.detailTextView.text = self.messages[indexPath.row].detail
        cell.likeCountLabel.text = self.messages[indexPath.row].likes.decimalString
        cell.countryLabel.text = self.messages[indexPath.row].countryName
        bindShareButton(button: cell.shareButton)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 192)
    }
    
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
