//
//  DWAlertViewController.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/07.
//

import RxSwift
import UIKit

final class DWAlertViewController: UIViewController, Promisable {
  typealias Expected = Bool
  // MARK: 🖼 UI
  let okButton: UIButton = UIButton()
  let cancelButton: UIButton = UIButton()
  
  private let titleText: String?
  private let messageText: String?
  
  private let disposeBag: DisposeBag = DisposeBag()
  
  // MARK: 🏁 Initialize
  init(title: String? = nil, message: String? = nil) {
    self.titleText = title
    self.messageText = message
    
    super.init(nibName: nil, bundle: nil)
    setupUI()
    bind()
  }
  
  required init?(coder: NSCoder) {
    self.titleText = nil
    self.messageText = nil
    super.init(coder: coder)
    
    setupUI()
    bind()
  }
  
  // MARK: 📍 Setup
  private func setupUI() {
    self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    
    let alertView: UIView = UIView().then {
      $0.backgroundColor = .breathingWhite
      $0.layer.masksToBounds = true
      $0.layer.cornerRadius = 25
    }
    self.view.addSubview(alertView)
    alertView.snp.makeConstraints {
      $0.centerY.equalToSuperview().multipliedBy(0.815)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(271)
      $0.height.equalTo(190)
    }
    
    let titleLabel: UILabel = UILabel().then {
      $0.font = .boldSystemFont(ofSize: 17)
      $0.textAlignment = .center
      $0.textColor = .warmBlue
      $0.text = titleText
      $0.numberOfLines = 0
    }
    alertView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().inset(30)
    }
    
    let messageLabel: UILabel = UILabel().then {
      $0.font = .systemFont(ofSize: 12)
      $0.textAlignment = .center
      $0.textColor = .warmBlue
      $0.text = messageText
    }
    alertView.addSubview(messageLabel)
    messageLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(titleLabel.snp.bottom).offset(10)
    }
    let buttonsStackView: UIStackView = UIStackView().then {
      $0.addArrangedSubview(cancelButton)
      $0.addArrangedSubview(okButton)
      $0.axis = .horizontal
      $0.distribution = .fillEqually
      $0.alignment = .fill
      $0.spacing = 10
    }
    alertView.addSubview(buttonsStackView)
    buttonsStackView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview().inset(20)
    }
    
    okButton.do {
      $0.setTitle("OK", for: .normal)
      $0.backgroundColor = .warmBlue
      $0.setTitleColor(.breathingWhite, for: .normal)
      $0.layer.cornerRadius = 19
      $0.layer.masksToBounds = true
      $0.titleLabel?.font = .systemFont(ofSize: 14)
    }
    okButton.snp.makeConstraints {
      $0.height.equalTo(38)
    }
    cancelButton.do {
      $0.setTitle("Cancel", for: .normal)
      $0.backgroundColor = .loveRed
      $0.setTitleColor(.breathingWhite, for: .normal)
      $0.layer.cornerRadius = 19
      $0.layer.masksToBounds = true
      $0.titleLabel?.font = .systemFont(ofSize: 14)
    }
    cancelButton.snp.makeConstraints {
      $0.height.equalTo(38)
    }
  }
  
  private func bind() {
    okButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { _ in true }
      .do(onNext: { [weak self] _ in
        self?.close()
      })
      .bind(to: expected)
      .disposed(by: disposeBag)
    
    cancelButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { _ in false }
      .do(onNext: { [weak self] _ in
        self?.close()
      })
      .bind(to: expected)
      .disposed(by: disposeBag)
  }
  
  private func close() {
    DispatchQueue.main.async { [weak self] in
      self?.dismiss(animated: false, completion: nil)
    }
  }
//
//  func answer() -> Observable<Bool> {
//    Observable<Bool>.create { [weak self] observer in
//      guard let self = self else { return Disposables.create() }
//      Observable.merge(
//        self.okButton.rx.tap.map { _ in true },
//        self.cancelButton.rx.tap.map { _ in false }
//      )
//      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
//      .subscribe(onNext: { [weak self] in
//        observer.onNext($0)
//        self?.dismiss(animated: true, completion: nil)
//        observer.onCompleted()
//      })
//      .disposed(by: self.disposeBag)
//
//      return Disposables.create()
//    }
//  }
}
