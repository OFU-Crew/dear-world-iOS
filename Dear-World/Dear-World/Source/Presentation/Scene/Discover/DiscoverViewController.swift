//
//  DiscoverViewController.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/25.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

final class DiscoverViewController: UIViewController, View {
    private let messageCountBadgeView: MessageCountBadgeView = MessageCountBadgeView()
    private let filterContainerView: UIView = UIView()
    private let countryLabel: UILabel = UILabel()
    private let messageCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var messages: [MessageMock] = []
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .breathingWhite
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        self.reactor = DiscoverReactor()
    }
    func bind(reactor: DiscoverReactor) {
        
        //TODO: RxCocoa import되면 Binder extension 만들 것
        reactor.state
            .map(\.messageCount)
            .subscribe { [weak self] count in
                self?.messageCountBadgeView.count = count
            }
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map(\.messages)
            .subscribe(onNext: {[weak self] mess in
                self?.messages = mess
                self?.messageCollectionView.reloadData()
            })
            .disposed(by: self.disposeBag)
        
        self.countryLabel
            .rx.observe(String.self, "text")
            .distinctUntilChanged()
            .map{$0!}
            .map{Reactor.Action.countryDidChanged(country: $0)}
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func setupUI() {
        self.view.addSubview(self.messageCountBadgeView)
        
        self.view.addSubview(self.filterContainerView)
        self.filterContainerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.messageCountBadgeView.snp.bottom).offset(30)
            $0.height.equalTo(26)
        }
        
        countryLabel.do {
            $0.font = .boldSystemFont(ofSize: 22)
            $0.textColor = .warmBlue
            $0.text = "Whole world"
        }
        
        filterContainerView.addSubview(countryLabel)
        countryLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(filterContainerView.snp.leading)
        }
        
        let select: UIImageView = UIImageView().then {
            $0.image = UIImage(named: "select")
        }
        filterContainerView.addSubview(select)
        select.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(14)
            $0.height.equalTo(8)
            $0.trailing.equalTo(filterContainerView.snp.trailing)
            $0.leading.equalTo(countryLabel.snp.trailing).offset(5)
        }
        
        messageCollectionView.backgroundColor = .breathingWhite
        self.view.addSubview(self.messageCollectionView)
        self.messageCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterContainerView.snp.bottom).offset(30)
            $0.trailing.leading.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.equalTo(300)
        }
    }
    
    private func setupCollectionView() {
        self.messageCollectionView.register(MessageTableViewCell.self, forCellWithReuseIdentifier: "messageCell")
        self.messageCollectionView.delegate = self
        self.messageCollectionView.dataSource = self
        
        let layout: UICollectionViewFlowLayout = self.messageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 20
    }
}
extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCell", for: indexPath) as? MessageTableViewCell else {return UICollectionViewCell()}
        cell.nameLabel.text = self.messages[indexPath.row].name
        cell.emojiLabel.text = self.messages[indexPath.row].emoji
        cell.detailTextView.text = self.messages[indexPath.row].detail
        cell.likeCountLabel.text = self.messages[indexPath.row].likes.decimalString
        cell.countryLabel.text = self.messages[indexPath.row].countryName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 192)
    }
    
}
