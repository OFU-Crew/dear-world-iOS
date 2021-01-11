//
//  SelectImageBottomSheet.swiwt
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/11.
//

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

final class ItemBottomSheetViewController<Item: BottomSheetItem>: UIViewController, Promisable, View {
  
  typealias Expected = Item
  typealias Reactor = ItemBottomSheetReactor<Item>
  typealias Action = Reactor.Action
  
  // MARK: 🖼 UI
  private let closeButton: UIButton = UIButton()
  private let bottomSheetHeaderView: BottomSheetItemHeaderView<Item> = BottomSheetItemHeaderView()
  private let itemsTableView: UITableView = UITableView()
  
  var disposeBag: DisposeBag = DisposeBag()
  
  // MARK: 🏁 Initialize
  init() {
    super.init(nibName: nil, bundle: nil)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: 🎛 Setup
  private func setupUI() {
    self.view.do {
      $0.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    let bottomSheet: UIStackView = UIStackView().then {
      $0.axis = .vertical
    }
    self.view.addSubview(bottomSheet)
    bottomSheet.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
    }
    
    let headerBar: UIView = UIView().then {
      $0.layer.cornerRadius = 15
      $0.layer.maskedCorners = [.layerMinXMinYCorner,
                                .layerMaxXMinYCorner]
      $0.backgroundColor = .white
    }
    bottomSheet.addArrangedSubview(headerBar)
    headerBar.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(52)
    }
    
    closeButton.do {
      $0.setImage(UIImage(named: "cancel"), for: .normal)
      $0.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    headerBar.addSubview(closeButton)
    closeButton.snp.makeConstraints {
      $0.size.equalTo(52)
      $0.top.trailing.equalToSuperview()
    }
    
    bottomSheet.addArrangedSubview(bottomSheetHeaderView)
    bottomSheetHeaderView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(56)
    }
    bottomSheet.addArrangedSubview(itemsTableView)
    
    itemsTableView.do {
      $0.rowHeight = 56
      $0.separatorStyle = .none
      $0.register(BottomSheetItemCell.self, forCellReuseIdentifier: "BottomSheetItemCell")
    }
    itemsTableView.snp.makeConstraints {
      $0.top.equalTo(bottomSheetHeaderView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(442)
    }
  }
  
  // MARK: 🔗 Bind
  func bind(reactor: Reactor) {
    self.view.rx.tapGesture()
      .skip(1)
      .map { _ in Action.tapBackground }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    closeButton.rx.tap
      .map { Action.tapClose }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    itemsTableView.rx.itemSelected
      .map { Action.selectItem(at: $0.row) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state.distinctUntilChanged(\.$items)
      .map { $0.items }
      .bind(to: itemsTableView.rx.items(
        cellIdentifier: "BottomSheetItemCell",
        cellType: BottomSheetItemCell.self
      )) { index, item, cell in
        cell.configure(item: item)
      }
      .disposed(by: disposeBag)
    
    reactor.state.distinctUntilChanged(\.$selectedItem)
      .map { $0.selectedItem }
      .filterNil()
      .bind(to: bottomSheetHeaderView.selectedItem)
      .disposed(by: disposeBag)
    
    reactor.state.distinctUntilChanged(\.$isPresent)
      .filter { !$0.isPresent }
      .subscribe(onNext: { [weak self] _ in
        self?.dismiss(animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
  }
}

