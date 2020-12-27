//
//  NetworkErrorView.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/27.
//

import UIKit

final class ErrorView: UIView {
  // MARK: 🖼 UI
  private let imageView: UIImageView = UIImageView()
  private let messageLabel: UILabel = UILabel()
  let button: UIButton = UIButton()
  var errorReason: ErrorReason?
  
  // MARK: 🏁 Initialize
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
  
  init(reason: ErrorReason) {
    self.errorReason = reason
    super.init(frame: .zero)
    setupUI(with: errorReason)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupUI()
  }
  
  // MARK: 📍 Setup
  private func setupUI(with: ErrorReason? = nil) {
    backgroundColor = .breathingWhite
    guard let errorReason = errorReason else { return }
    
    self.addSubview(imageView)
    imageView.image = errorReason.image
    imageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.25)
      $0.leading.trailing.equalToSuperview().inset(20)
    }
    
    self.addSubview(messageLabel)
    messageLabel.do {
      $0.text = errorReason.message
      $0.numberOfLines = 0
      $0.textAlignment = .center
      $0.textColor = .warmBlue
      $0.font = .boldSystemFont(ofSize: 20)
    }
    messageLabel.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom).offset(30)
      $0.centerX.equalToSuperview()
    }
    
    self.addSubview(button)
    button.do {
      $0.layer.masksToBounds = true
      $0.layer.cornerRadius = 18
      $0.setTitle(errorReason.buttonTitle, for: .normal)
      $0.setTitleColor(.warmBlue, for: .normal)
      $0.setTitleColor(.breathingWhite, for: .selected)
      $0.setTitleColor(.breathingWhite, for: .focused)
      $0.setTitleColor(.breathingWhite, for: .highlighted)
      $0.setBackgroundImage(.from(color: .grayWhite), for: .normal)
      $0.setBackgroundImage(.from(color: .warmBlue), for: .focused)
      $0.setBackgroundImage(.from(color: .warmBlue), for: .highlighted)
      $0.setBackgroundImage(.from(color: .warmBlue), for: .selected)
      $0.titleLabel?.font = .systemFont(ofSize: errorReason.fontSize, weight: .medium)
      $0.contentEdgeInsets = UIEdgeInsets(top: 14, left: 48, bottom: 14, right: 48)
    }
    button.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.height.equalTo(48)
      $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(UIScreen.main.bounds.height * 0.2)
    }
  }
}
extension ErrorView {
  enum ErrorReason {
    case pageNotFound
    case networkConnectionFailure
    
    var image: UIImage {
      switch self {
      case .pageNotFound:
        return UIImage(named: "page_not_found")!
      case .networkConnectionFailure:
        return UIImage(named: "network_connection_failure")!
      }
    }
    
    var message: String {
      switch self {
      case .pageNotFound:
        return "Ooops..\nThis page does not exist."
      case .networkConnectionFailure:
        return "Oooooooooh...\nError with the Internet connection!\nTry it again!"
      }
    }
    
    var buttonTitle: String {
      switch self {
      case .pageNotFound:
        return "Go to main page"
      case .networkConnectionFailure:
        return "Refresh"
      }
    }
    
    var fontSize: CGFloat {
      switch self {
      case .pageNotFound:
        return 20
      case .networkConnectionFailure:
        return 16
      }
    }
  }
}
