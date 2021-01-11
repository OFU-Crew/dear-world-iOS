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
  private let nameLabel: UILabel = UILabel()
  
  let selectedItem: PublishRelay<Item> = PublishRelay()
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
      $0.backgroundColor = .breathingWhite
    }
    
    nameLabel.do {
      $0.textColor = .livelyBlue
      $0.font = .systemFont(ofSize: 14)
    }
    self.addSubview(nameLabel)
    nameLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(20)
    }
    
    let checkView: UIImageView = UIImageView().then {
      $0.image = UIImage(named: "check")
    }
    self.addSubview(checkView)
    checkView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(20)
      $0.width.equalTo(12)
      $0.height.equalTo(10)
    }
  }
  
  // MARK: 🔗 Bind
  private func bind() {
    selectedItem.map { $0.name }
      .distinctUntilChanged()
      .bind(to: nameLabel.rx.text)
      .disposed(by: disposeBag)
    
    selectedItem.map { $0.name.isEmpty }
      .distinctUntilChanged()
      .bind(to: self.rx.isHidden)
      .disposed(by: disposeBag)
  }
}
