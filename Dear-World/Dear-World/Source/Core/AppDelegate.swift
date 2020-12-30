//
//  AppDelegate.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/24.
//
import SnapKit
import Then
import UIKit
import RxSwift

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  
    let mainWindow: UIWindow = UIWindow()
    window = mainWindow
    mainWindow.rootViewController = makeTabBarController()
    mainWindow.makeKeyAndVisible()
    return true
  }
  func makeTabBarController() -> UITabBarController {
    return UITabBarController().then {
      $0.addChild(DiscoverViewController().then {
        $0.tabBarItem.image = UIImage(named: "message_default")?
          .withRenderingMode(.alwaysOriginal)
        $0.tabBarItem.selectedImage = UIImage(named: "message")?
          .withRenderingMode(.alwaysOriginal)
      })
      $0.addChild(SendMessageViewController().then {
        $0.tabBarItem.image = UIImage(named: "add")?
          .withRenderingMode(.alwaysOriginal)
      })
      $0.addChild(CheeringMapViewController().then {
        $0.tabBarItem.image = UIImage(named: "earth_default")?
          .withRenderingMode(.alwaysOriginal)
        $0.tabBarItem.selectedImage = UIImage(named: "earth_icon")?
          .withRenderingMode(.alwaysOriginal)
      })
      $0.tabBar.barTintColor = .white
      $0.tabBar.layer.masksToBounds = true
      $0.tabBar.layer.cornerRadius = 10
      $0.tabBar.layer.borderWidth = 0.02
      //TODO: 그림자 넣기
      
      $0.delegate = self
    }
  }
}
extension AppDelegate: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    if let _ = viewController as? SendMessageViewController {
      let vc = SendMessageViewController()
      tabBarController.addChild(vc)
      tabBarController.view.addSubview(vc.view)
      vc.view.frame.origin.y = tabBarController.view.frame.height
      UIView.animate(withDuration: 0.2) {
        vc.view.frame.origin.y = 0
      } completion: { (_) in
        tabBarController.willMove(toParent: tabBarController)
      }

      return false
    }
    return true
  }
}
