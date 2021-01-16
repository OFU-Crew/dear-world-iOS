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
  let bottomSheet: UIStackView = UIStackView()
  private let closeButton: UIButton = UIButton()
  private let bottomSheetHeaderView: BottomSheetItemHeaderView<Item> = BottomSheetItemHeaderView()
  private let itemsTableView: UITableView = UITableView()
  private var selectedItem: Item?
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
    bottomSheet.do {
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
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    reactor?.action.onNext(.tapBackground)
  }
  
  // MARK: 🔗 Bind
  func bind(reactor: Reactor) {
    
    bottomSheetHeaderView.rx.tapGesture()
      .skip(1)
      .map { _ in Action.tapHeader }
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
      )) { [weak self] _, item, cell in
        cell.isSelected = item.name == self?.selectedItem?.name
        cell.configure(item: item)
      }
      .disposed(by: disposeBag)
    
    reactor.state.distinctUntilChanged(\.$headerItem)
      .map { $0.headerItem }
      .filterNil()
      .bind(to: bottomSheetHeaderView.headerItem)
      .disposed(by: disposeBag)
    
    reactor.state.distinctUntilChanged(\.$headerItem)
      .map { $0.headerItem }
      .map { $0 == nil }
      .bind(to: bottomSheetHeaderView.rx.isHidden)
      .disposed(by: disposeBag)
    
    reactor.state.distinctUntilChanged(\.$selectedItem)
      .map { $0.selectedItem }
      .do { [weak self] in
        self?.selectedItem = $0
        self?.bottomSheetHeaderView.isSelected = $0?.name == self?.reactor?.currentState.headerItem?.name
      }
      .filterNil()
      .bind(to: expected)
      .disposed(by: disposeBag)
    
    reactor.state.distinctUntilChanged(\.$isPresent)
      .filter { !$0.isPresent }
      .subscribe(onNext: { [weak self] _ in
        self?.close()
      })
      .disposed(by: disposeBag)
  }
  
  private func close() {
    UIView.animate(withDuration: 0.3) {
      self.bottomSheet.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.bottom)
      }
      self.view.layoutIfNeeded()
    } completion: { [weak self] _ in
      self?.dismiss(animated: false, completion: nil)
    }
  }
}

