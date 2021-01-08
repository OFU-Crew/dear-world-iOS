//
//  SortSelectView.swift
//  Dear-World
//
//  Created by rookie.w on 2021/01/07.
//


import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

public final class SortTypeSelectController: UIViewController {
  private var sortTypes: [Message.Model.ListType] = Message.Model.ListType.allCases
  // MARK: 🖼 UI
  private var sortTypeTableView: UITableView = UITableView()
  private let exitButton: UIButton = UIButton()
  private var selectedSortType: Message.Model.ListType? = nil
  private let outsideView: UIView = UIView()
  let disposeBag: DisposeBag = DisposeBag()
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupTableView()
    bind()
  }
  
  // MARK: 🎛 Setup
  private func setupUI() {
    let insideView: UIView = UIView()
    self.view.addSubview(insideView)
    insideView.snp.makeConstraints {
      $0.height.equalTo(500)
      $0.bottom.leading.trailing.equalToSuperview()
    }
    self.view.addSubview(outsideView)
    outsideView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(insideView.snp.top)
    }
    
    insideView.do {
      $0.backgroundColor = .white
      $0.layer.masksToBounds = true
      $0.layer.cornerRadius = 15
    }
    self.exitButton.do {
      $0.setImage(UIImage(named: "cancel"), for: .normal)
      $0.tintColor = .warmBlue
    }
    insideView.addSubview(exitButton)
    self.exitButton.snp.makeConstraints {
      $0.size.equalTo(12)
      $0.top.trailing.equalToSuperview().inset(20)
    }
    self.sortTypeTableView.do {
      $0.backgroundColor = .white
    }
    insideView.addSubview(self.sortTypeTableView)
    self.sortTypeTableView.snp.makeConstraints {
      $0.top.equalTo(exitButton.snp.bottom).offset(10)
      $0.trailing.leading.bottom.equalToSuperview()
    }
  }
  private func setupTableView() {
    self.sortTypeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "sortTypeCell")
    self.sortTypeTableView.rowHeight = 56
    self.sortTypeTableView.separatorStyle = .none
  }
  
  // MARK: 🔗 Bind
  private func bind() {
    self.exitButton
      .rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .subscribe { _ in
        self.willMove(toParent: nil)
      }
      .disposed(by: self.disposeBag)
    
    self.outsideView
      .rx.tapGesture()
      .bind { _ in
        self.willMove(toParent: nil)
      }
      .disposed(by: self.disposeBag)
    
    Observable.just(self.sortTypes)
      .bind(to: self.sortTypeTableView.rx.items) { [weak self] (tableView, row, item) -> UITableViewCell in
        guard let self = self else { return UITableViewCell()}
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "sortTypeCell", for: IndexPath(row: row, section: 0))
        cell.textLabel?.text = item.title
        cell.textLabel?.textColor = .warmBlue
        cell.backgroundColor = .white
        if cell.subviews.count < 2 {
          self.addCheck(base: cell)
        }
        cell.subviews.last?.isHidden = true
        if self.selectedSortType == item {
          cell.textLabel?.textColor = .livelyBlue
          cell.backgroundColor = .breathingWhite
          cell.subviews.last?.isHidden = false
        }
        cell.textLabel?.font = .systemFont(ofSize: 14)
        let cellBackgroudView = UIView()
        cellBackgroudView.backgroundColor = .breathingWhite
        cell.selectedBackgroundView = cellBackgroudView
        return cell
      }
      .disposed(by: self.disposeBag)

    self.sortTypeTableView
      .rx.itemSelected
      .map{[weak self] in self?.sortTypes[$0.row]}
      .bind { [weak self] sortType in
        self?.selectedSortType = sortType
        self?.willMove(toParent: nil)
      }
      .disposed(by: self.disposeBag)
  }
  func addCheck(base: UIView) {
    let checkImage: UIImageView = UIImageView().then {
      $0.image = UIImage(named: "check")
    }
    base.addSubview(checkImage)
    checkImage.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(20)
      $0.width.equalTo(12)
      $0.height.equalTo(10)
      $0.centerY.equalToSuperview()
    }
  }
}

// present 함수
extension SortTypeSelectController {
  static func select(presenting: UIViewController, disposeBag: DisposeBag, selected: Message.Model.ListType?) -> Observable<Message.Model.ListType> {
    return Observable<Message.Model.ListType>.create { observer in
      guard let base = presenting.tabBarController else {
        observer.onError(NSError())
        return Disposables.create()
      }
      presenting.view.isUserInteractionEnabled = false
      let presented: SortTypeSelectController = SortTypeSelectController()
      presented.selectedSortType = selected
      presented.loadViewIfNeeded()
      base.addChild(presented)
      base.view.addSubview(presented.view)
      presented.view.frame.origin.y = base.view.frame.height
      UIView.animate(withDuration: 0.3) {
        presenting.view.alpha = 0.6
        presented.view.frame.origin.y = 0
      } completion: { _ in
        presented.didMove(toParent: base)
      }
      
      presented.rx.methodInvoked(#selector(UIViewController.willMove(toParent:)))
        .bind { _ in
          if let type: Message.Model.ListType = presented.selectedSortType {
            observer.onNext(type)
          }
          UIView.animate(withDuration: 0.3) {
            presenting.view.alpha = 1
            presented.view.frame.origin.y = base.view.frame.height
          } completion: { _ in
            presenting.view.isUserInteractionEnabled = true
            presented.view.removeFromSuperview()
            presented.removeFromParent()
            observer.onCompleted()
          }
        }.disposed(by: disposeBag)
      
      return Disposables.create()
    }
  }
}
