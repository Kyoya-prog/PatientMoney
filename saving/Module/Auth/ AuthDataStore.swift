import Foundation
import RxSwift

class AuthDataStore: AuthRepository {
    func signUp(mailAddress: String, password: String) -> Single<String> {
        Single.create { observer -> Disposable in
            ApiClient().request(SignUpTargetType(email: mailAddress, password: password)) { response in
                switch response {
                case let .success(model):
                    observer(.success(model.token))

                case let .failure(error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func signIn(mailAddress: String, password: String) -> Single<String> {
        Single.create { observer -> Disposable in
            ApiClient().request(SignInTargetType(email: mailAddress, password: password)) { response in
                switch response {
                case let .success(model):
                    observer(.success(model.token))

                case let .failure(error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
