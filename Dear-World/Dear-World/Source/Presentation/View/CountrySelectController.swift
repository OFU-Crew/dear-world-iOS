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

public final class CountrySelectController: UIViewController {
    private var countryTableView: UITableView = UITableView()
    private let countries: [String] = ["korea", "japan", "China", "USA", "asdf", "USA", "asdf", "USA", "asdf", "USA", "asdf"]
    private let exitButton: UIButton = UIButton()
    private var selectedCountry: String? = nil
    let disposeBag: DisposeBag = DisposeBag()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        bind()
    }
    private func setupUI() {
        self.view.do {
            $0.backgroundColor = .white
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 15
        }
        self.exitButton.do {
            $0.setImage(UIImage(named: "cancel"), for: .normal)
            $0.tintColor = .warmBlue
        }
        self.view.addSubview(exitButton)
        self.exitButton.snp.makeConstraints {
            $0.size.equalTo(12)
            $0.top.trailing.equalToSuperview().inset(20)
        }
        self.countryTableView.do {
            $0.backgroundColor = .white
        }
        self.view.addSubview(self.countryTableView)
        self.countryTableView.snp.makeConstraints {
            $0.top.equalTo(exitButton.snp.bottom).offset(10)
            $0.trailing.leading.bottom.equalToSuperview()
        }
    }
    private func setupTableView() {
        self.countryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "countryCell")
        self.countryTableView.rowHeight = 56
    }
    private func bind() {
        self.exitButton
            .rx.tap
            .bind { _ in
                self.willMove(toParent: nil)
            }
            .disposed(by: self.disposeBag)
        
        Observable.just(self.countries)
            .bind(to: self.countryTableView.rx.items) {(tableView, row, item) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: IndexPath(row: row, section: 0))
                cell.textLabel?.text = item
                cell.textLabel?.font = .systemFont(ofSize: 14)
                cell.textLabel?.textColor = .warmBlue
                //TODO: CheckMark 달기
                return cell
            }
            .disposed(by: self.disposeBag)
        
        self.countryTableView
            .rx.itemSelected
            .map{[weak self] in self?.countries[$0.row]}
            .bind { [weak self] country in
                self?.selectedCountry = country
                self?.willMove(toParent: nil)
            }
            .disposed(by: self.disposeBag)
    }
}

// present 함수
extension CountrySelectController {
    public static func selectCountry(presenting: UIViewController, disposeBag: DisposeBag) -> Observable<String> {
        return Observable<String>.create { observer in
            guard let base = presenting.tabBarController else {
                observer.onError(NSError())
                return Disposables.create()
            }
            presenting.view.isUserInteractionEnabled = false
            var presented: CountrySelectController = CountrySelectController()
            presented.loadViewIfNeeded()
            base.addChild(presented)
            base.view.addSubview(presented.view)
            presented.view.frame.origin.y = base.view.frame.height
            UIView.animate(withDuration: 0.3) {
                presenting.view.alpha = 0.6
                presented.view.frame.origin.y = base.view.frame.height - 500
            } completion: { (finished) in
                presented.didMove(toParent: base)
            }
            
            presented.rx.methodInvoked(#selector(UIViewController.willMove(toParent:)))
                .bind { _ in
                    if let country = presented.selectedCountry {
                        observer.onNext(country)
                    }
                    UIView.animate(withDuration: 0.3) {
                        presenting.view.alpha = 1
                        presented.view.frame.origin.y = base.view.frame.height
                    } completion: { (isFinished) in
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
//private class CountryCell: UITableViewCell {
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    func setupUI() {
//        self.do {
//            $0.frame.size.height = 100
//            $0.backgroundColor = .red
//        }
//    }
//}
