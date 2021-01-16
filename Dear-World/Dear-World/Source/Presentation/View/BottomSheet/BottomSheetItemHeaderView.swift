//
//  BottomSheetItemHeaderView.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/11.
//

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

final class BottomSheetItemHeaderView<Item: BottomSheetItem>: UIView {
  
  // MARK: 🖼 UI
  private let checkImageView: UIImageView = UIImageView()
  private let nameLabel: UILabel = UILabel()
  
  let headerItem: PublishRelay<Item> = PublishRelay()
  var isSelected: Bool = false {
    didSet {
      if isSelected {
        nameLabel.textColor = .livelyBlue
        backgroundColor = .breathingWhite
      } else {
        nameLabel.textColor = .warmBlue
        backgroundColor = .white
      }
      checkImageView.isHidden = !isSelected
    }
  }
  private let disposeBag: DisposeBag = DisposeBag()
  
  // MARK: 🏁 Initialize
  init() {
    super.init(frame: .zero)
    
    setupUI()
    bind()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: 🎛 Setup
  private func setupUI() {
    self.do {
      $0.backgroundColor = .white
    }
    
    nameLabel.do {
      $0.textColor = .warmBlue
      $0.font = .boldSystemFont(ofSize: 15)
    }
    self.addSubview(nameLabel)
    nameLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(20)
    }
    
    checkImageView.do {
      $0.isHidden = !isSelected
      $0.image = UIImage(named: "check")
    }
    self.addSubview(checkImageView)
    checkImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(20)
      $0.width.equalTo(12)
      $0.height.equalTo(10)
    }
  }
  
  // MARK: 🔗 Bind
  private func bind() {
    headerItem.map { $0.name }
      .distinctUntilChanged()
      .bind(to: nameLabel.rx.text)
      .disposed(by: disposeBag)
    
    headerItem.map { $0.name.isEmpty }
      .distinctUntilChanged()
      .bind(to: self.rx.isHidden)
      .disposed(by: disposeBag)
  }
}
