//
//  AppDelegate.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/24.
//
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
  
    let mainWindow: UIWindow = UIWindow()
    window = mainWindow
    mainWindow.rootViewController = MainTabBarController()
    mainWindow.makeKeyAndVisible()
    return true
  }
}
