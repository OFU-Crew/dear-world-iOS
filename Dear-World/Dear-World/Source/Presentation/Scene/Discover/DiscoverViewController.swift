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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let mainLogo: UIImageView = UIImageView().then {
            $0.image = UIImage(named: "earth")
        }
        view.addSubview(mainLogo)
        
        mainLogo.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(60)
        }
        
        let totalCount: UILabel = UILabel().then {
            $0.text = "10,000"
            $0.backgroundColor = UIColor.init(named: "livelyBlue")
            $0.layer.masksToBounds = true
            $0.layer.borderWidth = 2
            $0.layer.cornerRadius = 19
            $0.textAlignment = .center
            $0.textColor = UIColor(named: "warmBlue")
            $0.layer.borderColor = UIColor(named: "warmBlue")?.cgColor
        }
        view.addSubview(totalCount)
        totalCount.snp.makeConstraints {
            $0.width.equalTo(88)
            $0.height.equalTo(37)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainLogo.snp.bottom).offset(-6)
        }
    }
}

