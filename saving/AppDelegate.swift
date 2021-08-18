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
        /// ログイン済みかどうか
        if TokenManager.isLogin() {
            initialViewController = AuthRouter.assembleHomeModule()
        } else {
            initialViewController = AuthRouter.assembleSignInModule()
        }
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        return true
    }
}
