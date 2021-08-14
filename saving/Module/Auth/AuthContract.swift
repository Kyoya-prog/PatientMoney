import FirebaseAuth
import Foundation
import RxSwift
import UIKit.UIViewController

/// 認証Wireframe
protocol AuthWireFrame: AnyObject {
    // Dependency
    var viewController: UIViewController? { get }

    /// 新規登録画面を表示する
    func presentSignUpView()

    /// ログイン画面を表示する
    func presentSignInView()

    /// Home画面を表示する
    func presentHomeView()
}

/// 認証View
protocol AuthView: AnyObject {
    // Dependency
    var presenter: AuthPresentation! { get }
    /// エラーメッセージを表示する
    /// - parameter messages:エラーメッセージ配列
    func showError(messages: [String])
}

/// 認証Presentation
protocol AuthPresentation: AnyObject {
    // Dependency
    var view: AuthView? { get }
    var interactor: AuthUsecase! { get }
    var router: AuthWireFrame! { get }

    /// ログイン画面の完了ボタンが押された
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func didTapSigninFinishButton(mailAddress: String, password: String)

    /// 新規登録画面の完了ボタンが押された
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func didTapSignUpFinishButton(mailAddress: String, password: String)

    /// ログイン画面の画面変更ラベルがタップされた
    func didTapSignInChangeViewLabel()

    /// パスワードが短すぎないかをチェックする
    /// - parameter password:パスワード
    func checkPasswordLength(password: String)

    /// 新規登録画面の画面変更ラベルがタップされた
    func didTapSignUpChangeViewLabel()
}

/// 認証InteractorOutput
protocol AuthInteractorOutput: AnyObject {
    /// 認証の結果を出力する
    /// - parameter result 認証処理結果
    func outputAuthResult(result: Result<AuthDataResult, Error>)
}

/// 認証Usecase
protocol AuthUsecase: AnyObject {
    // Dependency
    var output: AuthInteractorOutput? { get }
    var repository: AuthRepository? { get }
    /// サインインする
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func signIn(mailAddress: String, password: String)

    /// 新規登録する
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func signUp(mailAddress: String, password: String)
}

protocol AuthRepository: AnyObject {
    /// サインインする
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func signIn(mailAddress: String, password: String) -> Single<String>

    /// 新規登録する
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func signUp(mailAddress: String, password: String) -> Single<String>
}
