import Foundation

class AuthInteractor: AuthUsecase {
    var output: AuthInteractorOutput?
    var repository: AuthRepository?

    func signIn(mailAddress: String, password: String) {
        repository?.signIn(mailAddress: mailAddress, password: password, completion: { result in
            switch result {
            case let .success(token):
                _ = token.token

            case let .failure(error):
                _ = error
            }
        })
    }

    func signUp(mailAddress: String, password: String) {
        repository?.signUp(mailAddress: mailAddress, password: password, completion: { result in
            switch result {
            case let .success(token):
                _ = token.token

            case let .failure(error):
                _ = error
            }
        })
    }
}
