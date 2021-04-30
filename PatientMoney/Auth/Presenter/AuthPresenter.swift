import Foundation

class AuthPresenter: AuthPresentation, AuthInteractorOutput {
    var view: AuthView?

    var interactor: AuthUsecase!

    var router: AuthWireFrame!

    func didTapSigninFinishButton(mailAddress: String, password: String) {
        interactor.signIn(mailAddress: mailAddress, password: password)
    }

    func didTapSignUpFinishButton(mailAddress: String, password: String) {
        interactor.signUp(mailAddress: mailAddress, password: password)
    }

    func outputError(message: String) {
        view?.showError(message: message)
    }

    func didTapSignInChangeViewLabel() {
        router.presentSignUpView()
    }

    func didTapSignUpChangeViewLabel() {
        router.presentSignInView()
    }
}
