import Foundation

class PatienceRegisterPresenter: PatienceRegisterPresentation, PatienceRegisterInteractorOutput {
    // MARK: RegisterPresentation
    var view: PatienceRegisterView?

    var interactor: PatienceUsecase!

    var router: AuthWireFrame!

    func didTapRegisterButton(patience: Patience) {
        interactor.registerPatienceData(date: patience.date, description: patience.description, money: patience.money, category: patience.category)
    }

    // MARK: RegisterInteractorOutput
    func outputRegisterError(error: Error) {
        view?.showError(message: L10n.PatienceRegisterPresenter.StatusNotification.Failure.title)
    }

    func outputRegisterSuccess() {
        view?.showSuccess(message: L10n.PatienceRegisterPresenter.StatusNotification.Success.title)
    }
}
