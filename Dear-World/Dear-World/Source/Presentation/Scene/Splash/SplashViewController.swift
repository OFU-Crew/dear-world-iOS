//
//  SplashViewController.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/29.
//

import Lottie
import SnapKit
import UIKit

final class SplashViewController: UIViewController {
  
  // MARK: 🏁 Initialize
  init() {
    super.init(nibName: nil, bundle: nil)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupUI()
  }
  
  // MARK: 📍 Setup
  private func setupUI() {
    self.view.backgroundColor = .breathingWhite
    let animation: Animation? = Animation.named("splash_1x")
    let animationView: AnimationView = AnimationView(animation: animation)
    self.view.addSubview(animationView)
    animationView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.center.equalToSuperview()
    }
    animationView.play()
  }
}
