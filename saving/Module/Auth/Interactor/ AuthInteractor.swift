import Foundation

class AuthInteractor: AuthUsecase {
    var output: AuthInteractorOutput?

    func signIn(mailAddress: String, password: String) {
        FirebaseAuthManeger.shared.signIn(email: mailAddress, password: password) { [weak self] result, error in
            // errorとresultがどちらともnilはあり得ない
            if let error = error {
                self?.output?.outputAuthResult(result: .failure(error))
            }
            if let result = result {
                self?.output?.outputAuthResult(result: .success(result))
            }
        }
    }

    func signUp(mailAddress: String, password: String) {
        FirebaseAuthManeger.shared.signUp(email: mailAddress, password: password) { [weak self] result, error in
            // errorとresultがどちらともnilはあり得ない
            if let error = error {
                self?.output?.outputAuthResult(result: .failure(error))
            }
            if let result = result {
                self?.output?.outputAuthResult(result: .success(result))
            }
        }
    }
}
