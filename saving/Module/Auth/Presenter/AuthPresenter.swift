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

    func checkPasswordLength(password: String) {
        errorMessages.removeAll(where: { $0 == "パスワードは8文字以上入力してください" })
        if password.count < 8 {
            errorMessages.append("パスワードは8文字以上入力してください")
        }
        view?.showError(messages: errorMessages)
    }

    func didTapSignInChangeViewLabel() {
        router.presentSignUpView()
    }

    func didTapSignUpChangeViewLabel() {
        router.presentSignInView()
    }

    // MARK: AuthInteractorOutput
    func outputAuthError(error: Error) {
        errorMessages.removeAll()
        errorMessages.append(ErrorMessageBuilder.buildAuthErrorMessage(error: error))
        view?.showError(messages: errorMessages)
    }

    private var errorMessages: [String] = []
}
