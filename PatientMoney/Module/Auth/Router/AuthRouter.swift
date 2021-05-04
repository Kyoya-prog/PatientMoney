import Foundation
import UIKit

class AuthRouter: AuthWireFrame {
    var viewController: UIViewController?

    static func assembleSignInModule() -> UIViewController {
        let signInView = SignInViewController()
        let presenter = AuthPresenter()
        let router = AuthRouter()
        let interactor = AuthInteractor()

        router.viewController = signInView
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = signInView
        interactor.output = presenter
        signInView.presenter = presenter

        return signInView
    }

    static func assembleSignUpModule() -> UIViewController {
        let signUpView = SignUpViewController()
        let presenter = AuthPresenter()
        let router = AuthRouter()
        let interactor = AuthInteractor()

        router.viewController = signUpView
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = signUpView
        interactor.output = presenter
        signUpView.presenter = presenter

        return signUpView
    }

    static func assembleHomeModule() -> UIViewController {
        let homeViewController = UITabBarController()
        let inputVC = UINavigationController(rootViewController: PatienceInputRouter.assembleRegisterModule())
        inputVC.tabBarItem = UITabBarItem(title: L10n.AppDelegate.HomeView.RegisterView.title, image: nil, selectedImage: nil)
        homeViewController.addChild(inputVC)
        let calendarVC = UINavigationController(rootViewController: PatienceCalendarRouter.assembleModule())
        calendarVC.tabBarItem = UITabBarItem(title: L10n.AppDelegate.HomeView.CalendarView.title, image: nil, selectedImage: nil)
        homeViewController.addChild(calendarVC)
        return homeViewController
    }

    // MARK: AuthWireFrame 
    func presentSignUpView() {
        let view = AuthRouter.assembleSignUpModule()
        view.modalPresentationStyle = .fullScreen
        viewController?.present(view, animated: true, completion: nil)
    }

    func presentSignInView() {
        let view = AuthRouter.assembleSignInModule()
        view.modalPresentationStyle = .fullScreen
        viewController?.present(view, animated: true, completion: nil)
    }

    func presentHomeView() {
        let homeView = AuthRouter.assembleHomeModule()
        homeView.modalPresentationStyle = .fullScreen
        viewController?.present(homeView, animated: true, completion: nil)
    }
}
