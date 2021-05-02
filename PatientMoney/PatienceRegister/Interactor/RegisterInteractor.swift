import Foundation

class RegisterInteractor: RegisterUsecase {
    var output: RegisterInteractorOutput?
    var repository: RegisterRepository!

    func registerPatienceData(date: Date, description: String, money: Int, category: String, completion: (Error?) -> Void) {
        if let error = repository.registerPatienceData(date: date, description: description, money: money, category: category) {
            output?.outputRegisterError(error: error)
        } else {
            output?.outputRegisterSuccess()
        }
    }
}
