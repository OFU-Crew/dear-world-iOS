//
//  MessageTableViewCell.swift
//  Dear-World
//
//  Created by rookie.w on 2020/12/26.
//

import UIKit

final class MessageTableViewCell: UICollectionViewCell {
    let emojiLabel: UILabel = UILabel()
    let nameLabel: UILabel = UILabel()
    let countryLabel: UILabel = UILabel()
    let detailTextView: UITextView = UITextView()
    // TODO: likeView를 커스텀뷰로 만들기
    let likeView: UIImageView = UIImageView()
    let likeCountLabel: UILabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
        setupUI()
    }
    
    private func setupUI() {
        self.do {
            $0.backgroundColor = .white
            $0.frame.size.width = 200
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 20
        }
        
        let emojiView: UIImageView = UIImageView().then {
            $0.image = UIImage(named: "emojiBox")
        }
        self.addSubview(emojiView)
        emojiView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(30)
            $0.height.width.equalTo(40)
        }
        
        self.emojiLabel.do {
            $0.text = "🎅🏻"
            // FIXME : 14처럼 고정된 값 없이 최대로 꽉차게 할 수 없는가?
            $0.font = .systemFont(ofSize: 14)
            $0.textAlignment = .center
        }
        self.addSubview(self.emojiLabel)
        self.emojiLabel.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.center.equalTo(emojiView)
        }
        
        self.nameLabel.do {
            $0.text = "Judy"
            $0.font = .boldSystemFont(ofSize: 16)
            $0.textColor = .warmBlue
        }
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints {
            $0.top.equalTo(emojiView.snp.top)
            $0.leading.equalTo(emojiView.snp.trailing).offset(10)
            $0.trailing.greaterThanOrEqualToSuperview().inset(30)
        }
        
        self.countryLabel.do {
            $0.text = "🇰🇷 South Korea"
            $0.font = .boldSystemFont(ofSize: 12)
            $0.textColor = .grayWhite
        }
        self.addSubview(self.countryLabel)
        self.countryLabel.snp.makeConstraints {
            $0.bottom.equalTo(emojiView.snp.bottom)
            $0.leading.equalTo(emojiView.snp.trailing).offset(10)
            $0.trailing.greaterThanOrEqualToSuperview().inset(30)
        }
        
        self.detailTextView.do {
            $0.text = "Hello world, dont worry because you’re strong enough to overcome this corona blue. At the end of the day, trust yourself. more"
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .black
            $0.textContainerInset = .zero
            $0.isScrollEnabled = false
            $0.isEditable = false
        }
        self.addSubview(self.detailTextView)
        self.detailTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(emojiView.snp.bottom).offset(10)
            $0.height.equalTo(43)
        }
        
        self.likeView.do {
            $0.image = UIImage(named: "heart")
        }
        self.addSubview(likeView)
        self.likeView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(29)
            $0.height.equalTo(17)
            $0.width.equalTo(20)
        }
        
        self.likeCountLabel.do {
            $0.font = .boldSystemFont(ofSize: 12)
            $0.textColor = .grayWhite
            $0.text = "32"
        }
        self.addSubview(self.likeCountLabel)
        self.likeCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(likeView.snp.centerY)
            $0.width.equalTo(16)
            $0.height.equalTo(14)
            $0.leading.equalTo(likeView.snp.trailing).offset(5)
        }
        
        let shareButton: UIButton = UIButton().then {
            $0.backgroundColor = .refreshingWhite
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 8
            $0.setImage(UIImage(named: "share"), for: .normal)
            $0.tintColor = .warmBlue
        }
        self.addSubview(shareButton)
        shareButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(25)
            $0.width.equalTo(30)
            $0.height.equalTo(25)
        }
    }
}
