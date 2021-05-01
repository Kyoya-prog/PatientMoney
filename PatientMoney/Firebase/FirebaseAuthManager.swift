import FirebaseAuth
import Foundation

/// Firebase認証マネージャー
class FirebaseAuthManeger {
    /// 共有インスタンス
    static let shared = FirebaseAuthManeger()

    /// サインインしているかどうか
    var isSignIn: Bool = {
        Auth.auth().currentUser != nil
    }()

    /// サインインする
    func signIn(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completion?(result, error)
        }
    }

    /// サインアップする
    func signUp(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            completion?(result, error)
        }
    }

    /// サインアウトする
    func signOut() throws {
        try Auth.auth().signOut()
    }

    func buildAuthErrorMessage(error: Error) -> String {
        let code = AuthErrorCode(rawValue: error._code)
        switch code {
        case .emailAlreadyInUse:
            return L10n.FirebaseAuthManager.Error.EmailAlreadyInUse.message

        case .invalidEmail:
            return L10n.FirebaseAuthManager.Error.InvalidEmail.message

        case .wrongPassword:
            return L10n.FirebaseAuthManager.Error.WrongPassword.message

        case .userNotFound:
            return L10n.FirebaseAuthManager.Error.UserNotFound.message

        default:
            return L10n.FirebaseAuthManager.Error.Default.message
        }
    }

    enum AuthErrorType {
        case emailAlreadyInUse
    }
}
