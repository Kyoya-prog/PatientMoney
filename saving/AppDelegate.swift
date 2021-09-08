//
//  AppDelegate.swift
//  PatientMoney
//
//  Created by 松山響也 on 2021/04/25.
//
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        var initialViewController: UIViewController

        if !AuthManager.isLogin() {
            let semaphore = DispatchSemaphore(value: 1)
            AuthManager.signUp { result in
                switch result {
                case let .success(token):
                    AuthManager.setToken(token: token)

                case .failure(_):
                    DispatchQueue.main.async {
                        self.presentAlert()
                    }
                }
                semaphore.signal()
            }

            semaphore.wait()
        }
        initialViewController = AuthRouter.assembleHomeModule()
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        return true
    }

    private func presentAlert() {
        self.window?.rootViewController = AuthFailedViewController()
        window?.makeKeyAndVisible()
    }
}
