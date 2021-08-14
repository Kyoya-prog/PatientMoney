import Foundation
import RxSwift

class AuthDataStore: AuthRepository {
    func signIn(mailAddress: String, password: String, completion: @escaping (Result<TokenEntity, MoyaResponseError>) -> Void) {
        ApiClient().request(SignInTargetType(email: mailAddress, password: password)) { result in
             completion(result)
        }
    }

    func signUp(mailAddress: String, password: String, completion: @escaping (Result<TokenEntity, MoyaResponseError>) -> Void) {
        ApiClient().request(SignInTargetType(email: mailAddress, password: password)) { result in
             completion(result)
        }
    }
}
