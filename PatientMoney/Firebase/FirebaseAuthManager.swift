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
}
