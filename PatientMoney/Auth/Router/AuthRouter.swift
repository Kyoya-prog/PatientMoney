import Foundation
import UIKit

class AuthRouter: AuthWireFrame {
    var viewController: UIViewController?

    func presentSignUpView() {
        let signUpView = SignUpViewController()
        let presenter = AuthPresenter()
        let router = AuthRouter()

        router.viewController = signUpView
        presenter.router = router
        signUpView.presenter = presenter

        signUpView.modalPresentationStyle = .fullScreen
        viewController?.present(signUpView, animated: true, completion: nil)
    }

    func presentSignInView() {
        let signInView = SignInViewController()
        let presenter = AuthPresenter()
        let router = AuthRouter()

        router.viewController = signInView
        presenter.router = router
        signInView.presenter = presenter

        signInView.modalPresentationStyle = .fullScreen
        viewController?.present(signInView, animated: true, completion: nil)
    }

    func presentHomeView() {
        print("homeview")
    }
}
