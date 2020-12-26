//
//  MessageTableViewCell.swift
//  Dear-World
//
//  Created by rookie.w on 2020/12/26.
//

import UIKit

class MessageTableViewCell: UICollectionViewCell {
//    let emojiView: UIView = UIView()
    let emojiImage = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setupUI()
    }
    
    func setupUI() {
        let emojiView: UIImageView = UIImageView().then {
            $0.backgroundColor = .yellow
        }
        self.backgroundColor = .red
        self.frame.size.width = 200
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        
    }

}
