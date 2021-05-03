//
//  AppDelegate.swift
//  PatientMoney
//
//  Created by 松山響也 on 2021/04/25.
//

import Firebase
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        var initialViewController: UIViewController

        let homeViewController = UITabBarController()
        let inputvc = UINavigationController(rootViewController: PatienceInputRouter.assembleRegisterModule())
        inputvc.tabBarItem = UITabBarItem(title: "記録", image: nil, selectedImage: nil)
        homeViewController.addChild(inputvc)
        let calendarVC = UINavigationController(rootViewController: PatienceCalendarRouter.assembleModule())
        calendarVC.tabBarItem = UITabBarItem(title: "カレンダー", image: nil, selectedImage: nil)
        homeViewController.addChild(calendarVC)
        if FirebaseAuthManeger.shared.isSignIn {
            initialViewController = homeViewController
        } else {
            initialViewController = ViewController()
        }
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        return true
    }
}
