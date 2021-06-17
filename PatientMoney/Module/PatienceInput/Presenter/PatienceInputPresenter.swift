import Foundation

class PatienceInputPresenter: PatienceInputPresentation, PatienceInputInteractorOutput {
    // MARK: RegisterPresentation
    var view: PatienceInputView?

    var interactor: PatienceUsecase!

    var router: PatienceInputWireframe!

    func didTapInputButton(date: Date, memo: String, money: Int, categoryTitle: String) {
        interactor.registerPatienceData(record: PatienceEntity(documentID: "", date: date, memo: memo, money: money, categoryTitle: categoryTitle))
    }

    // MARK: RegisterInteractorOutput
    func outputInputError(error: Error) {
        view?.showError(message: L10n.PatienceRegisterPresenter.StatusNotification.RegisterFailure.title)
    }

    func outputInputSuccess() {
        view?.showSuccess(message: L10n.PatienceRegisterPresenter.StatusNotification.RegisterSuccess.title)
    }
}
