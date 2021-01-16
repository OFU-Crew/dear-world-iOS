//
//  AboutViewController.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/26.
//

import MessageUI
import ReactorKit
import UIKit

final class AboutViewController: UIViewController, View {
  typealias Reactor = AboutReactor
  typealias Action = Reactor.Action
  
  // MARK: 🖼 UI
  private let stackView: UIStackView = UIStackView()
  private let crewInfoView: UIView = UIView()
  private let contactInfoView: UIView = UIView()
  private let noticeInfoView: UIView = UIView()
  private let noticeBadge: NoticeBadge = NoticeBadge()
  private let versionInfoView: UIView = UIView()
  private let versionLabel: UILabel = UILabel()
  private let backButton: UIBarButtonItem = UIBarButtonItem(
    image: UIImage(named: "back")!,
    style: .plain,
    target: nil,
    action: nil
  )
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.navigationController?.navigationBar.isHidden = false
  }
  
  // MARK: 🎛 Setup
  private func setupUI() {
    view.backgroundColor = .breathingWhite
    backButton.tintColor = .warmBlue
    navigationItem.leftBarButtonItem = backButton
    navigationItem.title = "About"
    
    view.addSubview(stackView)
    stackView.do {
      $0.axis = .vertical
      $0.spacing = 20
      $0.addArrangedSubview(crewInfoView)
      $0.addArrangedSubview(contactInfoView)
      $0.addArrangedSubview(noticeInfoView)
      $0.addArrangedSubview(versionInfoView)
    }
    stackView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
    }
    
    let crewInfoTitleLabel: UILabel = UILabel().then {
      $0.text = "Dear world, we are OFU Crew."
      $0.font = .boldSystemFont(ofSize: 14)
      $0.textColor = .warmBlue
    }
    let crewContentImageView: UIImageView = UIImageView().then {
      $0.image = UIImage(named: "ufo")
    }
    crewInfoView.do {
      $0.backgroundColor = .refreshingWhite
      $0.addSubview(crewInfoTitleLabel)
      $0.addSubview(crewContentImageView)
      $0.layer.cornerRadius = 10
    }
    crewInfoTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    crewContentImageView.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview()
    }
    crewInfoView.snp.makeConstraints {
      $0.height.equalTo(57)
    }
    let contactInfoTitleLabel: UILabel = UILabel().then {
      $0.text = "Contact"
      $0.font = .boldSystemFont(ofSize: 14)
      $0.textColor = .warmBlue
    }
    let contactContentImageView: UIImageView = UIImageView().then {
      $0.image = UIImage(named: "left_arrow")
    }
    contactInfoView.do {
      $0.backgroundColor = .refreshingWhite
      $0.addSubview(contactInfoTitleLabel)
      $0.addSubview(contactContentImageView)
      $0.layer.cornerRadius = 10
    }
    contactInfoTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    contactInfoView.snp.makeConstraints {
      $0.height.equalTo(57)
    }
    contactContentImageView.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    
    let noticeInfoTitleLabel: UILabel = UILabel().then {
      $0.text = "Notice"
      $0.font = .boldSystemFont(ofSize: 14)
      $0.textColor = .warmBlue
    }
    noticeBadge.do {
      $0.text = "1"
    }
    noticeInfoView.do {
      $0.backgroundColor = .refreshingWhite
      $0.addSubview(noticeInfoTitleLabel)
      $0.addSubview(noticeBadge)
      $0.layer.cornerRadius = 10
    }
    noticeInfoTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    noticeBadge.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    noticeInfoView.snp.makeConstraints {
      $0.height.equalTo(57)
    }
    noticeInfoView.isHidden = true
    let versionInfoTitleLabel: UILabel = UILabel().then {
      $0.text = "Version Info."
      $0.font = .boldSystemFont(ofSize: 14)
      $0.textColor = .warmBlue
    }
    versionLabel.do {
      $0.text = "New Version"
      $0.font = .boldSystemFont(ofSize: 16)
      $0.textColor = .livelyBlue
    }
    versionInfoView.do {
      $0.backgroundColor = .refreshingWhite
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
    
    contactInfoView.rx.tapGesture()
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .skip(1)
      .map { _ in Action.tapContact }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    backButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { Action.tapClose }
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
      .bind(to: noticeBadge.rx.text)
      .disposed(by: disposeBag)
    
    reactor.state
      .distinctUntilChanged(\.$isPresentCrewInfo)
      .map { $0.isPresentCrewInfo }
      .filter { $0 }
      .subscribe(onNext: { _ in
        let viewController: UIViewController = AboutTeamViewController().then {
          $0.reactor = AboutTeamReactor()
        }
        self.navigationController?.pushViewController(viewController, animated: true)
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
      .distinctUntilChanged(\.$isPresentEmail)
      .map { $0.isPresentEmail }
      .filter { $0 }
      .subscribe(onNext: { [weak self] _ in
        if MFMailComposeViewController.canSendMail() {
          let viewController = MFMailComposeViewController().then {
            $0.setToRecipients(["dearworld.crew@gmail.com"])
            $0.setSubject("Dear world 에게 문의드립니다.")
            $0.setMessageBody("문의사항", isHTML: false)
          }
          viewController.mailComposeDelegate = self
          self?.present(viewController, animated: true, completion: nil)
        } else {
          let alert = UIAlertController(title: "알림", message: "메일을 발신할 수 없습니다", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
          self?.present(alert, animated: true, completion: nil)
        }
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
    
    reactor.state
      .distinctUntilChanged(\.$willDismiss)
      .map { $0.willDismiss }
      .filter { $0 }
      .subscribe(onNext: { [weak self] _ in
        self?.dismiss(animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.currentVersion }
      .distinctUntilChanged()
      .bind(to: versionLabel.rx.text)
      .disposed(by: disposeBag)
    
    reactor.action.onNext(.initalize)
  }
}
extension AboutViewController: MFMailComposeViewControllerDelegate {
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
}
