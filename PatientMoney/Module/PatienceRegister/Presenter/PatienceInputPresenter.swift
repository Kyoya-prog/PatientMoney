import Foundation

class PatienceInputPresenter: PatienceInputPresentation, PatienceInputInteractorOutput {
    // MARK: RegisterPresentation
    var view: PatienceInputView?

    var interactor: PatienceUsecase!

    var router: PatienceInputWireframe!

    var documentId: String?

    func didTapRegisterButton(date: Date, memo: String, money: Int, categoryTitle: String) {
        interactor.registerPatienceData(date: date, memo: memo, money: money, category: categoryTitle)
    }

    func didTapUpdateButton(date: Date, memo: String, money: Int, categoryTitle: String) {
        guard let documentId = documentId else { return }
        interactor.updatePatienceData(record: PatienceEntity(documentID: documentId, date: date, memo: memo, money: money, categoryTitle: categoryTitle))
    }

    // MARK: RegisterInteractorOutput
    func outputRegisterError(error: Error) {
        view?.showError(message: L10n.PatienceInputPresenter.StatusNotification.Failure.title)
    }

    func outputRegisterSuccess() {
        router.dismissInputModal()
        view?.showSuccess(message: L10n.PatienceInputPresenter.StatusNotification.RegisterSuccess.title)
    }

    func outputUpdateSuccess() {
        router.closeInputView()
        view?.showSuccess(message: L10n.PatienceInputPresenter.StatusNotification.UpdateSuccess.title)
    }
}
