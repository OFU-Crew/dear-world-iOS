//
//  AboutViewController.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/26.
//

import ReactorKit
import UIKit

final class AboutViewController: UIViewController, View {
  
  typealias Reactor = AboutReactor
  typealias Action = Reactor.Action
  
  // MARK: 🖼 UI
  private let stackView: UIStackView = UIStackView()
  private let crewInfoView: UIView = UIView()
  private let noticeInfoView: UIView = UIView()
  private let noticeCountLabel: UILabel = UILabel()
  private let versionInfoView: UIView = UIView()
  
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
  
  // MARK: 🎛 Setup
  private func setupUI() {
    view.backgroundColor = .breathingWhite
    
    view.addSubview(stackView)
    stackView.do {
      $0.axis = .vertical
      $0.spacing = 20
      $0.addArrangedSubview(crewInfoView)
      $0.addArrangedSubview(noticeInfoView)
      $0.addArrangedSubview(versionInfoView)
    }
    stackView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(20)
    }
    
    let crewInfoTitleLabel: UILabel = UILabel().then {
      $0.text = "Dear world, we are OFU Crew."
      $0.font = .systemFont(ofSize: 14)
      $0.textColor = .warmBlue
    }
    let crewContentLabel: UILabel = UILabel().then {
      $0.text = "🛸"
    }
    crewInfoView.do {
      $0.backgroundColor = .grayWhite
      $0.addSubview(crewInfoTitleLabel)
      $0.addSubview(crewContentLabel)
      $0.layer.cornerRadius = 10
    }
    crewInfoTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    crewContentLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    crewInfoView.snp.makeConstraints {
      $0.height.equalTo(57)
    }
    
    let noticeInfoTitleLabel: UILabel = UILabel().then {
      $0.text = "Notice"
      $0.font = .systemFont(ofSize: 14)
      $0.textColor = .warmBlue
    }
    noticeCountLabel.do {
      $0.text = "1"
      $0.backgroundColor = .warmBlue
      $0.textColor = .illuminatingYellow
      $0.layer.cornerRadius = 5
      $0.layer.masksToBounds = true
    }
    noticeInfoView.do {
      $0.backgroundColor = .grayWhite
      $0.addSubview(noticeInfoTitleLabel)
      $0.addSubview(noticeCountLabel)
      $0.layer.cornerRadius = 10
    }
    noticeInfoTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    noticeCountLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    noticeInfoView.snp.makeConstraints {
      $0.height.equalTo(57)
    }
    
    let versionInfoTitleLabel: UILabel = UILabel().then {
      $0.text = "Version Info."
      $0.font = .systemFont(ofSize: 14)
      $0.textColor = .warmBlue
    }
    let versionLabel: UILabel = UILabel().then {
      $0.text = "New Version"
      $0.textColor = .livelyBlue
    }
    versionInfoView.do {
      $0.backgroundColor = .grayWhite
      $0.addSubview(versionInfoTitleLabel)
      $0.addSubview(versionLabel)
      $0.layer.cornerRadius = 10
    }
    versionInfoTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    versionLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    versionInfoView.snp.makeConstraints {
      $0.height.equalTo(57)
    }
  }
  
  // MARK: 🔗 Bind
  func bind(reactor: AboutReactor) {
    crewInfoView.rx.tapGesture()
      .when(.recognized)
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { _ in Action.tapCrewInfo }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    noticeInfoView.rx.tapGesture()
      .when(.recognized)
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { _ in Action.tapNotice }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    versionInfoView.rx.tapGesture()
      .when(.recognized)
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { _ in Action.tapVersion }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state
      .map { $0.noticeCount }
      .distinctUntilChanged()
      .filterNil()
      .map { "\($0)" }
      .bind(to: noticeCountLabel.rx.text)
      .disposed(by: disposeBag)
    
    reactor.state
      .distinctUntilChanged(\.$isPresentCrewInfo)
      .map { $0.isPresentCrewInfo }
      .filter { $0 }
      .subscribe(onNext: { _ in
        print("isPresentCrewInfo")
      })
      .disposed(by: disposeBag)
    
    reactor.state
      .distinctUntilChanged(\.$isPresentNotice)
      .map { $0.isPresentNotice }
      .filter { $0 }
      .subscribe(onNext: { _ in
        print("isPresentNotice")
      })
      .disposed(by: disposeBag)
    
    reactor.state
      .distinctUntilChanged(\.$isPresentAppStore)
      .map { $0.isPresentAppStore }
      .filter { $0 }
      .subscribe(onNext: { _ in
        print("isPresentAppStore")
      })
      .disposed(by: disposeBag)
  }
}
