//
//  DiscoverViewController.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/25.
//

import SnapKit
import Then
import UIKit

final class DiscoverViewController: UIViewController {
    private let messageCountBadgeView: MessageCountBadgeView = MessageCountBadgeView()
    private let filterContainerView: UIView = UIView()
    private let countryLabel: UILabel = UILabel()
    private let messageCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init() {
        super.init(nibName: nil, bundle: nil)
        //FIXME: 배경색 변경
        self.view.backgroundColor = .breathingWhite
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
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
        self.messageCollectionView.register(MessageTableViewCell.self, forCellWithReuseIdentifier: "cell")
        self.messageCollectionView.delegate = self
        self.messageCollectionView.dataSource = self
        
        let layout = self.messageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 20
    }
}
extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 192)
    }
    
}
