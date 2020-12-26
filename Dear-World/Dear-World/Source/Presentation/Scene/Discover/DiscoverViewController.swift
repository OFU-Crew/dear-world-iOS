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
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        //FIXME: 배경색 변경
        self.view.backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    }
}

