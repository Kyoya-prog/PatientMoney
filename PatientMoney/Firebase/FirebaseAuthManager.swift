import FirebaseAuth
import Foundation

/// Firebase認証マネージャー
class FirebaseAuthManeger {
    /// 共有インスタンス
    static let shared = FirebaseAuthManeger()

    /// サインインしているかどうか
    lazy var isSignIn: Bool = {
        if let user = Auth.auth().currentUser {
            uid = user.uid
            return true
        } else {
            return false
        }
    }()

    /// サインインする
    func signIn(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let user = Auth.auth().currentUser {
                self?.uid = user.uid
            }
            completion?(result, error)
        }
    }

    /// サインアップする
    func signUp(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let user = Auth.auth().currentUser {
                self?.uid = user.uid
            }
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

    var uid: String

    private init() {
        uid = ""
    }
}
