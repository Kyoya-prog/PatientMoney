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
        let homeView = ViewController()
        homeView.modalPresentationStyle = .fullScreen
        viewController?.present(homeView, animated: true, completion: nil)
    }
}
