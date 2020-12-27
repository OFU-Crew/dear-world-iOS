//
//  AppDelegate.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/24.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let tabBarController: UITabBarController = UITabBarController()
    tabBarController.addChild(DiscoverViewController())
    tabBarController.addChild(CheeringMapViewController())
    tabBarController.addChild(SendMessageViewController())
    
    let mainWindow: UIWindow = UIWindow()
    window = mainWindow
    mainWindow.rootViewController = tabBarController
    mainWindow.makeKeyAndVisible()
    return true
  }
}
