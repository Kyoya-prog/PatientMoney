import Foundation

class PatienceInputPresenter: PatienceInputPresentation, PatienceInputInteractorOutput {
    // MARK: RegisterPresentation
    var view: PatienceInputView?

    var interactor: PatienceUsecase!

    var router: AuthWireFrame!

    var documentId: String?

    func didTapRegisterButton(patience: Patience) {
        interactor.registerPatienceData(date: patience.date, description: patience.description, money: patience.money, category: patience.category)
    }

    func didTapUpdateButton(patience: Patience) {
        guard let documentId = documentId else { return }
        interactor.updatePatienceData(record: .init(documentID: documentId, date: patience.date, description: patience.description, money: patience.money, categoryTitle: patience.category))
    }

    // MARK: RegisterInteractorOutput
    func outputRegisterError(error: Error) {
        view?.showError(message: L10n.PatienceInputPresenter.StatusNotification.Failure.title)
    }

    func outputRegisterSuccess() {
        view?.showSuccess(message: L10n.PatienceInputPresenter.StatusNotification.Success.title)
    }
}
