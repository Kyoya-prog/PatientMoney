import Foundation

class RegisterPresenter: RegisterPresentation, RegisterInteractorOutput {
    // MARK: RegisterPresentation
    var view: RegisterView?

    var interactor: RegisterUsecase!

    var router: AuthWireFrame!

    func didTapRegisterButton(patience: Patience) {
        outputRegisterSuccess()
//        interactor.registerPatienceData(date: patience.date, description: patience.discription, money: patience.money, category: patience.category) { [weak self] (error) in
//            if let error = error{
//                self?.outputRegisterError(error: error)
//            }else {
//                self?.outputRegisterSuccess()
//            }
//        }
    }

    // MARK: RegisterInteractorOutput
    func outputRegisterError(error: Error) {
        view?.showError(message: "error")
    }

    func outputRegisterSuccess() {
        view?.showError(message: "success")
    }
}
