//
//  CheeringMapViewController.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/26.
//

import ReactorKit
import RxCocoa
import RxGesture
import RxOptional
import RxSwift
import SnapKit
import Then
import UIKit

final class CheeringMapViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = CheeringMapReactor
  typealias Action = Reactor.Action
  
  // MARK: 🖼 UI
  private let messageCountBadgeView: MessageCountBadgeView = MessageCountBadgeView()
  private let cheeringCountLabel: UILabel = UILabel()
  private let titleLabel: UILabel = UILabel()
  private let worldMapView: PixelMapView = PixelMapView()
  private let headerView: UIView = UIView()
  private let aboutButton: UIButton = UIButton()
  private let rankingTableView: UITableView = UITableView()
  
  private var titleHeight: CGFloat = 26
  private var worldMapHeight: CGFloat = 208
  private var canScrollTableView: Bool = false
  
  var disposeBag: DisposeBag = DisposeBag()
  
  // MARK: 🏁 Initialize
  init() {
    super.init(nibName: nil, bundle: nil)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupUI()
  }
  
  // MARK: 🔗 Bind
  func bind(reactor: CheeringMapReactor) {
    reactor.state
      .map { $0.messageCount }
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] in
        self?.messageCountBadgeView.count = $0
      })
      .disposed(by: disposeBag)
    
    reactor.state
      .distinctUntilChanged(\.$rankers)
      .map { $0.rankers }
      .bind(to: rankingTableView.rx.items(cellIdentifier: "RankerTableViewCell", cellType: RankerTableViewCell.self)) {
        [weak self] index, ranker, cell in
        cell.configure(with: ranker, ranking: index + 1)
        cell.cheerUpButton.anchorView = self?.view
      }.disposed(by: disposeBag)
    
    reactor.state
      .distinctUntilChanged(\.$countries)
      .map { $0.countries }
      .subscribe(onNext: { [weak self] in
        self?.worldMapView.drawCountries($0)
      })
      .disposed(by: disposeBag)

    reactor.state
      .distinctUntilChanged(\.$isPresentAboutPage)
      .map { $0.isPresentAboutPage }
      .filter { $0 }
      .subscribe(onNext: { [weak self] _ in
        let viewController = AboutViewController().then {
          $0.reactor = AboutReactor()
        }
        let naviController = UINavigationController(rootViewController: viewController).then {
          $0.modalPresentationStyle = .fullScreen
        }
        self?.present(naviController, animated: false, completion: nil)
      })
      .disposed(by: self.disposeBag)
    
    aboutButton.rx.tap
      .map { Action.tapAbout }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    rankingTableView.rx.didScroll
      .map { [weak self] in self?.rankingTableView.contentOffset.y }
      .filterNil()
      .throttle(.milliseconds(40), scheduler: MainScheduler.instance)
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] y in
        guard let self = self else { return }
        self.updateLayouts(y)
        if let countries = self.reactor?.currentState.countries {
          self.worldMapView.drawCountries(countries)
        }
      })
      .disposed(by: disposeBag)
    
    reactor.action.onNext(.viewDidLoad)
  }
  
  // MARK: 📍 Setup
  private func setupUI() {
    self.view.backgroundColor = .breathingWhite
    
    self.view.addSubview(messageCountBadgeView)
    messageCountBadgeView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(16)
      $0.centerX.equalToSuperview()
    }
    
    titleLabel.do {
      $0.text = "Cheering Map"
      $0.font = .boldSystemFont(ofSize: 22)
      $0.textColor = .warmBlue
    }
    self.view.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.height.equalTo(titleHeight)
      $0.top.equalTo(messageCountBadgeView.snp.bottom).offset(28)
    }
    
    self.view.addSubview(worldMapView)
    worldMapView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(50)
      $0.height.equalTo(208.0)
      $0.width.equalTo(worldMapView.snp.height).multipliedBy(78.0 / 53.0)
      $0.centerX.equalToSuperview()
    }
    
    self.view.addSubview(aboutButton)
    aboutButton.do {
      $0.setImage(UIImage(named: "about"), for: .normal)
    }
    aboutButton.snp.makeConstraints {
      $0.size.equalTo(20)
      $0.top.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
    }
    
    let headerTitleLabel: UILabel = UILabel().then {
      $0.text = "Cheer Rank"
      $0.font = .boldSystemFont(ofSize: 18)
      $0.textColor = .warmBlue
    }
    headerView.addSubview(headerTitleLabel)
    headerView.do {
      $0.backgroundColor = .white
      $0.layer.masksToBounds = true
      $0.layer.cornerRadius = 20
      $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    headerTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview().inset(10)
    }
    self.view.addSubview(rankingTableView)
    self.view.addSubview(headerView)
    headerView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(55)
      $0.top.equalTo(worldMapView.snp.bottom).offset(50)
    }
    
    rankingTableView.do {
      $0.backgroundColor = .white
      $0.showsVerticalScrollIndicator = false
      $0.register(RankerTableViewCell.self, forCellReuseIdentifier: "RankerTableViewCell")
      $0.rowHeight = UITableView.automaticDimension
      $0.estimatedRowHeight = 64
      $0.allowsSelection = false
      $0.separatorStyle = .none
    }
    rankingTableView.snp.makeConstraints {
      $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
      $0.bottom.equalToSuperview()
      $0.top.equalTo(headerView.snp.bottom)
    }
  }
  
  private func updateLayouts(_ tableViewOffsetY: CGFloat) {
    worldMapHeight -= tableViewOffsetY
    worldMapHeight = max(0, worldMapHeight)
    worldMapHeight = min(208, worldMapHeight)
    worldMapView.snp.updateConstraints {
      $0.height.equalTo(worldMapHeight)
    }
    titleHeight -= tableViewOffsetY / 8
    titleHeight = max(0, worldMapHeight)
    titleHeight = min(26, worldMapHeight)
    titleLabel.snp.updateConstraints {
      $0.height.equalTo(titleHeight)
    }
  }
}
