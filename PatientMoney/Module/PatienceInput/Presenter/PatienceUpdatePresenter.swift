import Foundation

class PatienceUpdatePreseneter: PatienceUpdatePresentation, PatienceInputInteractorOutput {
    /// ドキュメントID
    var id: String?
    // MARK: RegisterPresentation
    var view: PatienceInputView?

    var interactor: PatienceUsecase!

    var router: PatienceInputWireframe!

    func didTapUpdateButton(date: Date, memo: String, money: Int, categoryTitle: String) {
        guard let id = id else { return }
        interactor.updatePatienceData(record: PatienceEntity(documentID: id, date: date, memo: memo, money: money, categoryTitle: categoryTitle))
    }

    // MARK: RegisterInteractorOutput
    func outputInputError(error: Error) {
        view?.showError(message: L10n.PatienceUpdatePresenter.StatusNotification.UpdateFailure.title)
    }

    func outputInputSuccess() {
        router.dismissInputModal()
        view?.showSuccess(message: L10n.PatienceUpdatePresenter.StatusNotification.UpdateSuccess.title)
    }
}
