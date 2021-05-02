import Foundation

class RegisterInteractor: RegisterUsecase {
    var output: RegisterInteractorOutput?
    var repository: RegisterRepository!

    func registerPatienceData(date: Date, description: String, money: Int, category: String) {
        let documentData = ["Date": date, "Memo": description, "Money": money, "Category": category, "UID": uid] as [String: Any]
        if let error = repository.registerPatienceData(data: documentData) {
            output?.outputRegisterError(error: error)
        } else {
            output?.outputRegisterSuccess()
        }
    }

    private var uid: String = {
        FirebaseAuthManeger.shared.uid
    }()
}
