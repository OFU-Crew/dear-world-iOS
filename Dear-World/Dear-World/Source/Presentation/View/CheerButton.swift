//
//  CheerButton.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/26.
//

import RxCocoa
import RxSwift
import UIKit

final class CheerUpButton: UIButton {
  
  // MARK: 🦴 State
  enum Active {
    static let image: UIImage = UIImage(named: "heart_liked")!
    static let backgroundImage: UIImage = .from(color: .refreshingWhite)
  }
  enum Deactive {
    static let image: UIImage = UIImage(named: "heart")!
    static let backgroundImage: UIImage = .from(color: .white)
  }
  
  var emitter: CAEmitterLayer?
  weak var anchorView: UIView?
  private let disposeBag: DisposeBag = DisposeBag()
  
  // MARK: 🏁 Initialize
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupUI()
  }
  
  // MARK: 📍 Setup
  private func setupUI() {
    self.setImage(Active.image, for: .highlighted)
    self.setImage(Active.image, for: .focused)
    self.setImage(Active.image, for: .selected)
    self.setImage(Deactive.image, for: .normal)
    self.setBackgroundImage(Active.backgroundImage, for: .highlighted)
    self.setBackgroundImage(Active.backgroundImage, for: .focused)
    self.setBackgroundImage(Active.backgroundImage, for: .selected)
    self.setBackgroundImage(Deactive.backgroundImage, for: .normal)
    layer.do {
      $0.cornerRadius = 16
      $0.masksToBounds = true
      $0.borderWidth = 1
      $0.borderColor = UIColor.grayWhite.cgColor
    }
    self.addTarget(self, action: #selector(activateEffect), for: .touchDown)
    self.addTarget(self, action: #selector(deactivateEffect), for: [.touchUpInside, .touchUpOutside])
  }
  
//  func active() {
//    self.imageView?.image = Active.image
//    self.backgroundColor = .refreshingWhite
//  }
//
//  func deactive() {
//    self.imageView?.image = Deactive.image
//    self.backgroundColor = .white
//  }
  @objc
  func activateEffect() {
    guard let view = anchorView, let emitter = emitter else { return }
    let point: CGPoint = convert(self.bounds.origin, to: view)
    emitter.emitterPosition = CGPoint(
      x: point.x + (self.bounds.width / 2),
      y: point.y + (self.bounds.height / 2)
    )
    let heart: CAEmitterCell = CAEmitterCell().then {
      $0.birthRate = 8
      $0.lifetime = 2
      $0.velocity = 100
      $0.velocityRange = -5
      $0.scale = 0.4
      $0.scaleRange = -0.15
      $0.scaleSpeed = -0.14
      $0.emissionLongitude = -(CGFloat.pi / 2)
      $0.emissionRange = 0.3
      $0.alphaRange = -70
      $0.alphaSpeed = -0.5
      $0.contents = UIImage(named: "heart_liked")?.cgImage
    }
    emitter.emitterCells = [heart]
    emitter.removeFromSuperlayer()
    view.layer.addSublayer(emitter)
  }
  
  @objc
  func deactivateEffect() {
    emitter?.contents = []
    emitter?.removeFromSuperlayer()
    emitter = nil
  }
}
