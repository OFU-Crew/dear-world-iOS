//
//  SendMessageViewController.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/26.
//

import ReactorKit
import RxCocoa
import RxKeyboard
import RxOptional
import RxSwift
import UIKit
import UITextView_Placeholder

final class SendMessageViewController: UIViewController, View {
  
  typealias Reactor = SendMessageReactor
  typealias Action = Reactor.Action
  
  // MARK: 🖼 UI
  private let closeButton: UIButton = UIButton()
  private let titleLabel: UILabel = UILabel()
  private let sendButton: UIButton = UIButton()
  private let selectCountryView: SelectCountryView = SelectCountryView()
  private let emojiLabel: UILabel = UILabel()
  private let refreshButton: UIButton = UIButton()
  private let nameTextField: UITextField = UITextField()
  private let nameCountLabel: UILabel = UILabel()
  private let messageTextView: TextView = TextView()
  private let bottomBar: UIView = UIView()
  private let messageLimitGaugeBar: UIProgressView = UIProgressView()
  private let messageStatusMessageLabel: UILabel = UILabel()
  private let arrowImageViews: UIStackView = UIStackView()
  
  var disposeBag: DisposeBag = DisposeBag()
  
  // MARK: 🏁 Initialize
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  // MARK: 🔗 Bind
  func bind(reactor: Reactor) {
    closeButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { Action.tapClose }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    refreshButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { Action.tapRefresh }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    nameTextField.rx.text
      .filterNil()
      .distinctUntilChanged()
      .map { Action.typeName($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    messageTextView.rx.text
      .filterNil()
      .distinctUntilChanged()
      .map { Action.typeMessage($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    sendButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { Action.tapSendMessage }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state.map(\.isPresented)
      .map { !$0 }
      .subscribe(onNext: { [weak self] willDismiss in
        guard willDismiss else { return }
        self?.dismiss(animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
    
    reactor.state.map(\.emoji)
      .distinctUntilChanged()
      .bind(to: emojiLabel.rx.text)
      .disposed(by: disposeBag)
    
    reactor.state.map(\.canSendMessage)
      .distinctUntilChanged()
      .bind(to: sendButton.rx.isEnabled)
      .disposed(by: disposeBag)
    
    reactor.state.map(\.name)
      .filter { [weak self] name in
        self?.nameTextField.text != name
      }
      .bind(to: nameTextField.rx.text)
      .disposed(by: disposeBag)
    
    reactor.state.map(\.nameStatusMessage)
      .distinctUntilChanged()
      .bind(to: nameCountLabel.rx.attributedText)
      .disposed(by: disposeBag)
    
    reactor.state.map(\.message)
      .filter { [weak self] message in
        self?.messageTextView.text != message
      }
      .bind(to: messageTextView.rx.text)
      .disposed(by: disposeBag)
    
    reactor.state.map(\.messageLimitGauge)
      .distinctUntilChanged()
      .bind(to: messageLimitGaugeBar.rx.progress)
      .disposed(by: disposeBag)
    
    reactor.state.map(\.messageStatusMessage)
      .distinctUntilChanged()
      .bind(to: messageStatusMessageLabel.rx.attributedText)
      .disposed(by: disposeBag)
  }
  
  // MARK: 📍 Setup
  private func setupUI() {
    self.view.backgroundColor = .breathingWhite
    
    self.view.addSubview(titleLabel)
    titleLabel.do {
      $0.text = "Send Message"
      $0.font = .boldSystemFont(ofSize: 18)
      $0.textColor = .warmBlue
    }
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(66)
      $0.centerX.equalToSuperview()
    }
    
    self.view.addSubview(closeButton)
    closeButton.setBackgroundImage(UIImage(named: "cancel_16"), for: .normal)
    closeButton.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.centerY.equalTo(titleLabel)
    }
    
    self.view.addSubview(sendButton)
    sendButton.do {
      $0.setTitle("Send", for: .normal)
      $0.setTitleColor(.livelyBlue, for: .normal)
      $0.setTitleColor(.grayWhite, for: .disabled)
      $0.titleLabel?.font = .boldSystemFont(ofSize: 18)
    }
    sendButton.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(20)
      $0.centerY.equalTo(titleLabel)
    }
    
    let separatorView: UIView = UIView().then { $0.backgroundColor = .grayWhite }
    self.view.addSubview(separatorView)
    separatorView.snp.makeConstraints {
      $0.height.equalTo(1)
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(sendButton.snp.bottom).offset(15)
    }
    
    self.view.addSubview(selectCountryView)
    selectCountryView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.top.equalTo(separatorView.snp.bottom).offset(20)
      $0.height.equalTo(53)
    }
    
    let profileBackgroundView: UIView = UIView()
    self.view.addSubview(profileBackgroundView)
    profileBackgroundView.do {
      $0.backgroundColor = .grayWhite
      $0.layer.cornerRadius = 40
      $0.layer.masksToBounds = true
    }
    profileBackgroundView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(selectCountryView.snp.bottom).offset(20)
      $0.width.height.equalTo(80)
    }
    
    self.view.addSubview(emojiLabel)
    emojiLabel.do {
      $0.backgroundColor = .grayWhite
      $0.font = .systemFont(ofSize: 40)
    }
    emojiLabel.snp.makeConstraints {
      $0.center.equalTo(profileBackgroundView)
    }
    
    self.view.addSubview(refreshButton)
    refreshButton.do {
      $0.backgroundColor = .warmBlue
      $0.layer.cornerRadius = 15
      $0.layer.masksToBounds = true
      $0.layer.borderWidth = 3
      $0.layer.borderColor = UIColor.breathingWhite.cgColor
      $0.setImage(UIImage(named: "refresh"), for: .normal)
    }
    refreshButton.snp.makeConstraints {
      $0.trailing.bottom.equalTo(profileBackgroundView).offset(3)
      $0.width.height.equalTo(30)
    }
    
    self.view.addSubview(nameTextField)
    nameTextField.do {
      $0.attributedPlaceholder = NSAttributedString(
        string: "My Name is..",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayWhite]
      )
      $0.textAlignment = .center
      $0.font = .boldSystemFont(ofSize: 18)
      $0.borderStyle = .none
      $0.textColor = .warmBlue
    }
    nameTextField.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(profileBackgroundView.snp.bottom).offset(20)
    }
    
    self.view.addSubview(nameCountLabel)
    nameCountLabel.do {
      $0.font = .boldSystemFont(ofSize: 18)
      $0.textColor = .grayWhite
    }
    nameCountLabel.snp.makeConstraints {
      $0.leading.equalTo(nameTextField.snp.trailing).offset(5)
      $0.centerY.equalTo(nameTextField)
    }
    
    self.view.addSubview(messageTextView)
    self.view.addSubview(bottomBar)
    messageTextView.do {
      $0.backgroundColor = .breathingWhite
      $0.placeholder = "Write down a message of cheering and encouragement to people or your story that you want to be comforted."
      $0.placeholderColor = .grayWhite
      $0.textColor = .warmBlue
      $0.font = .systemFont(ofSize: 14)
    }
    messageTextView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(18)
      $0.top.equalTo(nameTextField.snp.bottom).offset(20)
      $0.bottom.equalTo(bottomBar.snp.top).offset(-16)
    }
    
    bottomBar.do {
      $0.backgroundColor = .breathingWhite
    }
    bottomBar.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(48)
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
    }
    
    self.view.addSubview(messageLimitGaugeBar)
    messageLimitGaugeBar.do {
      $0.progressTintColor = .livelyBlue
      $0.tintColor = .grayWhite
    }
    messageLimitGaugeBar.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
      $0.bottom.equalTo(bottomBar.snp.top)
    }
    
    bottomBar.addSubview(messageStatusMessageLabel)
    messageStatusMessageLabel.do {
      $0.textColor = .grayWhite
      $0.font = .systemFont(ofSize: 14)
    }
    messageStatusMessageLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(20)
    }
    
    let earthImageView: UIImageView = UIImageView().then {
      $0.image = UIImage(named: "earth")!
    }
    bottomBar.addSubview(earthImageView)
    earthImageView.snp.makeConstraints {
      $0.width.height.equalTo(16)
      $0.bottom.equalTo(bottomBar).inset(16)
      $0.trailing.equalTo(bottomBar).inset(20)
    }
    
    let speechBubbleImageView: UIImageView = UIImageView().then {
      $0.image = UIImage(named: "speech_bubble_lively_blue")
    }
    let waitingLabel: UILabel = UILabel().then {
      $0.text = "Waiting.."
      $0.textColor = .breathingWhite
      $0.textAlignment = .center
      $0.font = .systemFont(ofSize: 11)
    }
    bottomBar.addSubview(speechBubbleImageView)
    bottomBar.addSubview(waitingLabel)
    speechBubbleImageView.snp.makeConstraints {
      $0.center.equalTo(waitingLabel)
    }
    waitingLabel.snp.makeConstraints {
      $0.trailing.equalTo(earthImageView.snp.leading).offset(-20)
      $0.centerY.equalTo(earthImageView)
    }
    
    arrowImageViews.do {
      $0.addArrangedSubview(UIImageView(image: UIImage(named: "going_arrow")!).then { $0.alpha = 0.3 })
      $0.addArrangedSubview(UIImageView(image: UIImage(named: "going_arrow")!).then { $0.alpha = 0.6 })
      $0.addArrangedSubview(UIImageView(image: UIImage(named: "going_arrow")!).then { $0.alpha = 1.0 })
      $0.axis = .horizontal
      $0.spacing = 5
    }
    bottomBar.addSubview(arrowImageViews)
    arrowImageViews.snp.makeConstraints {
      $0.centerY.equalTo(waitingLabel)
      $0.trailing.equalTo(waitingLabel.snp.leading).offset(-20)
    }
    
    self.view.rx.tapGesture()
      .subscribe(onNext: { [weak self] _ in
        self?.view.endEditing(true)
      })
      .disposed(by: disposeBag)
    
    RxKeyboard.instance.visibleHeight
      .drive(onNext: { [weak self] keyboardHeight in
        self?.updateBottomBarLayout(with: keyboardHeight)
      })
      .disposed(by: disposeBag)
    
    rotateArrowImageViews()
  }
  
  private func updateBottomBarLayout(with keyboardHeight: CGFloat) {
    var keyboardHeight: CGFloat = keyboardHeight
    if keyboardHeight > 0 {
      keyboardHeight -= self.view.safeAreaInsets.bottom
    }
    self.bottomBar.snp.updateConstraints {
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(keyboardHeight)
    }
  }
  
  // FIXME: 🛠 Timer로 구현해라 부엉아!
  private func rotateArrowImageViews() {
    guard let firstArrowImageView: UIView = arrowImageViews.arrangedSubviews.first else { return }
    arrowImageViews.removeArrangedSubview(firstArrowImageView)
    firstArrowImageView.removeFromSuperview()
    arrowImageViews.addArrangedSubview(firstArrowImageView)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
      self?.rotateArrowImageViews()
    }
  }
}
