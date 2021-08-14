import Foundation

class AuthInteractor: AuthUsecase {
    var output: AuthInteractorOutput?
    var repository: AuthRepository? = AuthDataStore()

    func signIn(mailAddress: String, password: String) {
        repository?.signIn(mailAddress: mailAddress, password: password).subscribe({ observer in
            switch observer {
            case let .success(token):
                print(token)

            case let .error(error):
                print(error)
            }
        }).dispose()
    }

    func signUp(mailAddress: String, password: String) {
        repository?.signUp(mailAddress: mailAddress, password: password).subscribe({ observer in
            switch observer {
            case let .success(token):
                print(token)

            case let .error(error):
                print(error)
            }
        }).dispose()
    }
}
