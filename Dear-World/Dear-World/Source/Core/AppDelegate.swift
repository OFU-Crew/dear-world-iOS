//
//  AppDelegate.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/24.
//
import Firebase
import RxSwift
import SnapKit
import Then
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    setupFirebase()
    setupInitialScene()
    return true
  }
  
  private func setupFirebase() {
    FirebaseApp.configure()
  }
  
  private func setupInitialScene() {
      let mainWindow: UIWindow = UIWindow()
      window = mainWindow
      mainWindow.rootViewController = UINavigationController(rootViewController: MainTabBarController()).then {
        $0.navigationBar.isHidden = true
      }
      mainWindow.makeKeyAndVisible()
  }
}
