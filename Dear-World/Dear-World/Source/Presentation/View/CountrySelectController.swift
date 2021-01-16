//
//  CountrySelectViewController.swift
//  Dear-World
//
//  Created by rookie.w on 2020/12/27.
//

import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

final class CountrySelectController: UIViewController {
  typealias Model = Message.Model
  // MARK: 🖼 UI
  private var countryTableView: UITableView = UITableView()
  private let countries: [Message.Model.Country] = AllCountries.shared.countries
  private let exitButton: UIButton = UIButton()
  private var selectedCountry: Message.Model.Country? = nil
  private let wholeWorldButton: UIButton = UIButton()
  private let outsideView: UIView = UIView()
  
  let disposeBag: DisposeBag = DisposeBag()
  
  override func viewDidLoad() {
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
    self.wholeWorldButton.do {
      if selectedCountry?.code == nil {
        $0.backgroundColor = .breathingWhite
        addCheck(base: $0)
      } else {
        $0.backgroundColor = .white
      }
    }
    insideView.addSubview(wholeWorldButton)
    let wholeWorldLabel: UILabel = UILabel().then {
      $0.text = "Whole world"
      $0.font = .systemFont(ofSize: 14)
      if selectedCountry?.code == nil {
        $0.textColor = .livelyBlue
      } else {
        $0.textColor = .warmBlue
      }
    }
    self.wholeWorldButton.addSubview(wholeWorldLabel)
    wholeWorldLabel.snp.makeConstraints {
      $0.bottom.top.leading.equalToSuperview().inset(20)
    }
    self.wholeWorldButton.snp.makeConstraints {
      $0.top.equalTo(exitButton.snp.bottom).offset(10)
      $0.trailing.leading.equalToSuperview()
      $0.height.equalTo(56)
    }
    self.countryTableView.do {
      $0.backgroundColor = .white
    }
    insideView.addSubview(self.countryTableView)
    self.countryTableView.snp.makeConstraints {
      $0.top.equalTo(wholeWorldButton.snp.bottom)
      $0.trailing.leading.bottom.equalToSuperview()
    }
  }
  private func setupTableView() {
    self.countryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "countryCell")
    self.countryTableView.rowHeight = 56
    self.countryTableView.separatorStyle = .none
  }
  
  // MARK: 🔗 Bind
  private func bind() {
    self.exitButton
      .rx.tap
      .bind { _ in
        self.willMove(toParent: nil)
      }
      .disposed(by: self.disposeBag)
    
    self.outsideView
      .rx.tapGesture()
      .bind { _ in
        self.willMove(toParent: nil)
      }
      .disposed(by: self.disposeBag)
    
    Observable.just(self.countries)
      .bind(to: self.countryTableView.rx.items) { [weak self] tableView, row, item -> UITableViewCell in
        guard let self = self else { return UITableViewCell() }
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: IndexPath(row: row, section: 0))
        cell.textLabel?.text = item.fullName
        cell.textLabel?.textColor = .warmBlue
        cell.backgroundColor = .white
        if cell.subviews.count < 2 {
          self.addCheck(base: cell)
        }
        cell.subviews.last?.isHidden = true
        if self.selectedCountry?.code == item.code {
          cell.textLabel?.textColor = .livelyBlue
          cell.backgroundColor = .breathingWhite
          cell.subviews.last?.isHidden = false
        }
        cell.textLabel?.font = .systemFont(ofSize: 14)
        let cellBackgroudView: UIView = UIView()
        cellBackgroudView.backgroundColor = .breathingWhite
        cell.selectedBackgroundView = cellBackgroudView
        cell.textLabel?.snp.makeConstraints {
          $0.left.equalToSuperview().inset(20)
          $0.centerY.equalToSuperview()
        }
        return cell
      }
      .disposed(by: self.disposeBag)
    
    self.wholeWorldButton
      .rx.tap
      .subscribe(onNext: { [weak self] in
        self?.selectedCountry = .init(
          code: nil,
          fullName: "Whole world",
          emojiUnicode: "🍎",
          imageURL: nil
        )
        self?.willMove(toParent: nil)
      })
      .disposed(by: self.disposeBag)
    
    self.countryTableView
      .rx.itemSelected
      .map { [weak self] in self?.countries[$0.row] }
      .subscribe(onNext: { [weak self] country in
        self?.selectedCountry = country
        self?.willMove(toParent: nil)
      })
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
extension CountrySelectController {
  
  static func selectCountry(
    presenting: UIViewController,
    disposeBag: DisposeBag,
    selected: Message.Model.Country?
  ) -> Observable<Message.Model.Country> {
    return Observable<Message.Model.Country>.create { observer in
      guard let base = presenting.tabBarController else {
        observer.onError(NSError())
        return Disposables.create()
      }
      presenting.view.isUserInteractionEnabled = false
      let presented: CountrySelectController = CountrySelectController()
      presented.selectedCountry = selected
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
          if let country: Message.Model.Country = presented.selectedCountry {
            observer.onNext(country)
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
  
  static func selectCountry(
    presenting: UIViewController,
    disposeBag: DisposeBag,
    selected: Message.Model.Country?
  ) -> Observable<Message.Model.Country?> {
    
    return .empty()
  }
}

public class AllCountries {
  static let shared: AllCountries = AllCountries()
  var countries: [Message.Model.Country] = []
  private init() {
    _ = Network.request(Message.API.Countries())
      .filterNil()
      .subscribe (onNext: { response in
        self.countries = response.countries
      })
  }
}
