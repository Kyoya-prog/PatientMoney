import Foundation

class PatienceRegisterPresenter: PatienceRegisterPresentation, PatienceInputInteractorOutput {
    // MARK: RegisterPresentation
    var view: PatienceInputView?

    var interactor: PatienceUsecase!

    var router: PatienceInputWireframe!

    func didTapRegisterButton(date: Date, memo: String, money: Int, categoryTitle: String) {
        interactor.registerPatienceData(record: PatienceEntity(id: 0, registeredAt: date, memo: memo, money: money, categoryTitle: categoryTitle))
    }

    // MARK: RegisterInteractorOutput
    func outputInputError(error: Error) {
        view?.showError(message: L10n.PatienceRegisterPresenter.StatusNotification.RegisterFailure.title)
    }

    func outputInputSuccess() {
        view?.showSuccess(message: L10n.PatienceRegisterPresenter.StatusNotification.RegisterSuccess.title)
    }
}
