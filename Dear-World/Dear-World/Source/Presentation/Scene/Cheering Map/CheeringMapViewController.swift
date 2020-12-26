//
//  CheeringMapViewController.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/26.
//

import RxCocoa
import RxGesture
import RxOptional
import RxSwift
import SnapKit
import Then
import UIKit

final class CheeringMapViewController: UIViewController {
  
  // MARK: 🖼 UI
  private let messageCountBadgeView: MessageCountBadgeView = MessageCountBadgeView()
  private let cheeringCountLabel: UILabel = UILabel()
  private let worldMapView: UIView = UIView()
  private let headerView: UIView = UIView()
  private let rankingTableView: UITableView = UITableView()
  
  private var worldMapHeight: CGFloat = 208
  
  private let disposeBag: DisposeBag = DisposeBag()
  
  // MARK: 🏁 Initialize
  init() {
    super.init(nibName: nil, bundle: nil)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupUI()
  }
  
  // MARK: 📍 Setup
  private func setupUI() {
    self.view.backgroundColor = .breathingWhite
    
    self.view.addSubview(messageCountBadgeView)
    messageCountBadgeView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(60)
    }
    
    let logoImageView: UIImageView = UIImageView().then {
      $0.image = UIImage(named: "earth")
    }
    self.view.addSubview(logoImageView)
    logoImageView.snp.makeConstraints {
      $0.bottom.equalToSuperview()
    }
    
    cheeringCountLabel.do {
      // FIXME: 🔮 더미 데이터 변경
      $0.text = 353_513.decimalString
    }
    self.view.addSubview(cheeringCountLabel)
    cheeringCountLabel.snp.makeConstraints {
      $0.bottom.equalToSuperview()
    }
    
    let titleLabel: UILabel = UILabel().then {
      $0.text = "Cheering Map"
      $0.font = .boldSystemFont(ofSize: 22)
      $0.textColor = .warmBlue
    }
    self.view.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(messageCountBadgeView.snp.bottom).offset(28)
    }
    
    self.view.addSubview(worldMapView)
    worldMapView.do {
      // FIXME: 🔮 셋업하고 변경
      $0.backgroundColor = .red
    }
    worldMapView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(50)
      $0.height.equalTo(208.0)
      $0.width.equalTo(worldMapView.snp.height).multipliedBy(335.0 / 208.0)
      $0.centerX.equalToSuperview()
    }
    let headerTitleLabel: UILabel = UILabel().then {
      $0.text = "Cheer Rank"
      $0.font = .boldSystemFont(ofSize: 18)
      $0.textColor = .warmBlue
    }
    headerView.addSubview(headerTitleLabel)
    headerTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview().inset(10)
    }
    headerView.snp.makeConstraints {
      $0.width.equalTo(UIScreen.main.bounds.width)
    }
    self.view.addSubview(rankingTableView)
    rankingTableView.do {
      $0.backgroundColor = .white
      $0.layer.cornerRadius = 20
      $0.tableHeaderView = headerView
      $0.contentOffset = CGPoint(x: 0, y: -55)
      $0.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryTableViewCell")
      $0.rowHeight = UITableView.automaticDimension
      $0.estimatedRowHeight = 64
      $0.dataSource = self
      $0.separatorStyle = .none
    }
    rankingTableView.snp.makeConstraints {
      $0.top.equalTo(worldMapView.snp.bottom).offset(50)
      $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
    }
    rankingTableView.rx.contentOffset
      .filter { $0.y > -50 }
      .map { $0.y + 55 }
      .filter { $0 > 1 }
      .throttle(.milliseconds(40), scheduler: MainScheduler.instance)
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] y in
        guard let self = self else { return }
        Logger.log(self.rankingTableView.contentOffset)
        Logger.log(y)
        self.worldMapHeight -= y
        self.worldMapHeight = max(0, self.worldMapHeight)
        self.worldMapHeight = min(208, self.worldMapHeight)
        self.worldMapView.snp.updateConstraints {
          $0.height.equalTo(self.worldMapHeight)
        }
        self.rankingTableView.contentOffset = CGPoint(x: 0, y: -55)
      })
      .disposed(by: disposeBag)
  }
}
extension CheeringMapViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int { 10 }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath)
  }
}
