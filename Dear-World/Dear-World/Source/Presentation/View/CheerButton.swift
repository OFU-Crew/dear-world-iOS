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
  
  var emitter: CAEmitterLayer? = CAEmitterLayer()
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
    self.addTarget(self, action: #selector(activate), for: .touchDown)
    self.addTarget(self, action: #selector(deactivate), for: [.touchUpInside,
                                                              .touchUpOutside,
                                                              .touchCancel,
                                                              .touchDragExit])
    self.addTarget(self, action: #selector(occurHapticFeedback), for: [.touchDown])
  }
  
  @objc
  private func occurHapticFeedback() {
    let generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    generator.impactOccurred()
    DispatchQueue.main
      .asyncAfter(deadline: .now() + 0.2) { [weak self] in
        guard self?.currentBackgroundImage == Active.backgroundImage else { return }
        self?.occurHapticFeedback()
      }
  }
  
  @objc
  private func activate() {
    guard let view = anchorView else { return }
    let emitter: CAEmitterLayer = {
      if let emitter: CAEmitterLayer = self.emitter {
        emitter.removeFromSuperlayer()
        return emitter
      }
      return CAEmitterLayer()
    }()
    self.emitter = emitter
    let point: CGPoint = convert(self.bounds.origin, to: view)
    emitter.emitterPosition = CGPoint(
      x: point.x + (self.bounds.width / 2),
      y: point.y + (self.bounds.height / 2)
    )
    let heart: CAEmitterCell = CAEmitterCell().then {
      $0.birthRate = 15
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
    view.layer.addSublayer(emitter)
    self.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    layer.cornerRadius = 14
  }
  
  @objc
  private func deactivate() {
    emitter?.contents = []
    emitter?.removeFromSuperlayer()
    emitter = nil
    
    self.contentEdgeInsets = .zero
    layer.cornerRadius = 16
  }
}
