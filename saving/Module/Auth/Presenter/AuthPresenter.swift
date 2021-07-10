import FirebaseAuth
import Foundation

class AuthPresenter: AuthPresentation, AuthInteractorOutput {
    // MARK: AuthPresentation
    var view: AuthView?

    var interactor: AuthUsecase!

    var router: AuthWireFrame!

    func didTapSigninFinishButton(mailAddress: String, password: String) {
        interactor.signIn(mailAddress: mailAddress, password: password)
    }

    func didTapSignUpFinishButton(mailAddress: String, password: String) {
        interactor.signUp(mailAddress: mailAddress, password: password)
    }

    func didTapSignInChangeViewLabel() {
        router.presentSignUpView()
    }

    func didTapSignUpChangeViewLabel() {
        router.presentSignInView()
    }

    // MARK: AuthInteractorOutput
    func outputAuthResult(result: Result<AuthDataResult, Error>) {
        switch result {
        case .success:
            router.presentHomeView()

        case .failure(let error):
            view?.showError(message: FirebaseAuthManeger.shared.buildAuthErrorMessage(error: error))
        }
    }
}
