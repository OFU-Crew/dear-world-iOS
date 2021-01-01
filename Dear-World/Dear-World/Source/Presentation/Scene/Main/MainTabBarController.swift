//
//  MainTabBarViewController.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/31.
//

import UIKit

final class MainTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTabBar()
    self.delegate = self
  }
  
  private func setupTabBar() {
    let discoverViewController: UIViewController = DiscoverViewController().then {
      $0.tabBarItem.image = UIImage(named: "message_default")?
        .withRenderingMode(.alwaysOriginal)
      $0.tabBarItem.selectedImage = UIImage(named: "message")?
        .withRenderingMode(.alwaysOriginal)
      $0.reactor = DiscoverReactor()
    }
    let sendMessageViewController: UIViewController = SendMessageViewController().then {
      $0.reactor = SendMessageReactor()
      $0.tabBarItem.image = UIImage(named: "add")?
        .withRenderingMode(.alwaysOriginal)
    }
    let cheeringMapViewController: UIViewController = CheeringMapViewController().then {
      $0.reactor = CheeringMapReactor()
      $0.tabBarItem.image = UIImage(named: "earth_default")?
        .withRenderingMode(.alwaysOriginal)
      $0.tabBarItem.selectedImage = UIImage(named: "earth_icon")?
        .withRenderingMode(.alwaysOriginal)
    }
    self.addChild(discoverViewController)
    self.addChild(sendMessageViewController)
    self.addChild(cheeringMapViewController)
  }
}

// MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    if viewController.isKind(of: SendMessageViewController.self) {
      presentSendMessageViewController()
      return false
    }
    return true
  }
  
  private func presentSendMessageViewController() {
    let sendMessageViewController: UIViewController = SendMessageViewController().then {
      $0.reactor = SendMessageReactor()
      $0.modalPresentationStyle = .fullScreen
    }
    self.present(sendMessageViewController, animated: true, completion: nil)
  }
}
