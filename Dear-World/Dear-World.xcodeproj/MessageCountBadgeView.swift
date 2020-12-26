//
//  MessageView.swift
//  Dear-World
//
//  Created by rookie.w on 2020/12/26.
//

import UIKit

import SnapKit
import Then

public final class MessageCountBadgeView: UIView {
    private var totalCount: UILabel = UILabel()
    
    public var count: Int? {
        didSet {
            self.totalCount.text = "\(count ?? 0)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupSubviews()
    }
    
    override public func didMoveToSuperview() {
        self.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(60)
        }
    }
    
    private func setupUI() {
        self.snp.makeConstraints {
            $0.width.equalTo(88)
            $0.height.equalTo(80)
        }
    }
    
    private func setupSubviews() {
        let mainLogo: UIImageView = UIImageView().then {
            $0.image = UIImage(named: "earth")
        }
        self.addSubview(mainLogo)
        mainLogo.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }

        let totalCountContainer: UIView = UIView().then {
            $0.backgroundColor = .livelyBlue
            $0.layer.masksToBounds = true
            $0.layer.borderWidth = 2
            $0.layer.cornerRadius = 19
            $0.layer.borderColor = UIColor.warmBlue.cgColor
        }
        self.addSubview(totalCountContainer)
        totalCountContainer.snp.makeConstraints {
            $0.width.equalTo(88)
            $0.height.equalTo(37)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainLogo.snp.bottom).offset(-6)
        }

        self.totalCount.do {
            $0.text = "-1"
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .warmBlue
        }
        totalCountContainer.addSubview(totalCount)
        totalCount.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
