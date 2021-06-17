import Foundation

class PatienceUpdatePreseneter: PatienceUpdatePresentation, PatienceInputInteractorOutput {
    /// ドキュメントID
    var documentId: String?
    // MARK: RegisterPresentation
    var view: PatienceInputView?

    var interactor: PatienceUsecase!

    var router: PatienceInputWireframe!

    func didTapUpdateButton(date: Date, memo: String, money: Int, categoryTitle: String) {
        guard let documentId = documentId else { return }
        interactor.updatePatienceData(record: PatienceEntity(documentID: documentId, date: date, memo: memo, money: money, categoryTitle: categoryTitle))
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
