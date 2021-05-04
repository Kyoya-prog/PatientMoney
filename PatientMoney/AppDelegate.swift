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

        if FirebaseAuthManeger.shared.isSignIn {
            initialViewController = AppDelegate.createHomeView()
        } else {
            initialViewController = ViewController()
        }
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        return true
    }

    static func createHomeView() -> UITabBarController {
        let homeViewController = UITabBarController()
        let inputvc = UINavigationController(rootViewController: PatienceInputRouter.assembleRegisterModule())
        inputvc.tabBarItem = UITabBarItem(title: L10n.AppDelegate.HomeView.RegisterView.title, image: nil, selectedImage: nil)
        homeViewController.addChild(inputvc)
        let calendarVC = UINavigationController(rootViewController: PatienceCalendarRouter.assembleModule())
        calendarVC.tabBarItem = UITabBarItem(title: L10n.AppDelegate.HomeView.CalendarView.title, image: nil, selectedImage: nil)
        homeViewController.addChild(calendarVC)
        return homeViewController
    }
}
