import Foundation

class PatienceUpdatePreseneter: PatienceUpdatePresentation, PatienceInputInteractorOutput {
    /// ID
    var id: Int?
    // MARK: RegisterPresentation
    var view: PatienceInputView?

    var interactor: PatienceUsecase!

    var router: PatienceInputWireframe!

    func didTapUpdateButton(date: Date, memo: String, money: Int, categoryTitle: String) {
        guard let id = id else { return }
        interactor.updatePatienceData(record: PatienceEntity(id: id, registeredAt: date, memo: memo, money: money, categoryTitle: categoryTitle))
    }

    // MARK: RegisterInteractorOutput
    func outputInputError(error: Error) {
        view?.showError(message: L10n.PatienceUpdatePresenter.StatusNotification.UpdateFailure.title)
    }

    func outputInputSuccess() {
        router.closeInputView()
        view?.showSuccess(message: L10n.PatienceUpdatePresenter.StatusNotification.UpdateSuccess.title)
    }
}
