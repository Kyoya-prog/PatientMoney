import Foundation

class RegisterPresenter: RegisterPresentation, RegisterInteractorOutput {
    // MARK: RegisterPresentation
    var view: RegisterView?

    var interactor: RegisterUsecase!

    var router: AuthWireFrame!

    func didTapRegisterButton(patience: Patience) {
        interactor.registerPatienceData(date: patience.date, description: patience.description, money: patience.money, category: patience.category)
    }

    // MARK: RegisterInteractorOutput
    func outputRegisterError(error: Error) {
        view?.showError(message: L10n.RegisterViewController.StatusNotification.Failure.title)
    }

    func outputRegisterSuccess() {
        view?.showSuccess(message: L10n.RegisterViewController.StatusNotification.Success.title)
    }
}
