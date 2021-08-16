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
        if password.count < 8 {
            view?.showError(message: "パスワードは８文字以上入力してください")
        }
        view?.changeFinishButtonEnable(isEnabled: 8 <= password.count)
    }

    func didTapSignInChangeViewLabel() {
        router.presentSignUpView()
    }

    func didTapSignUpChangeViewLabel() {
        router.presentSignInView()
    }

    // MARK: AuthInteractorOutput
    func outputAuthError(error: Error) {
        let message = ErrorMessageBuilder.buildErrorMessage(error: error, message: "認証に失敗しました")
        view?.showError(message: message)
    }
    
    func setAuthToken(token: String) {
        TokenManager.setToken(token: token)
        presentHomeView()
    }
    
    // MARK: Private
    
    private func presentHomeView() {
        router.presentHomeView()
    }
}
