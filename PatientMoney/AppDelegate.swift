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
            let view = RegisterViewController()
            let presenter = RegisterPresenter()
            let interactor = RegisterInteractor()
            let datastore = RegisterDataStore()

            interactor.repository = datastore
            interactor.output = presenter
            presenter.interactor = interactor
            presenter.view = view
            view.presenter = presenter
            initialViewController = view
        } else {
            initialViewController = ViewController()
        }
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        return true
    }
}
