import Foundation
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
    /// - parameter message:エラーメッセージ
    func showError(message: String)

    /// 完了ボタンを有効・無効にする
    func enableFinishButton(isEnabled: Bool)
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
    func didTapFinishSignInButton(mailAddress: String, password: String)
    
    /// 新規登録画面の完了ボタンが押された
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func didTapFinishSignUpButton(mailAddress: String, password: String)

    /// アカウントの入力状態が変化した
    /// - parameter password:パスワード
    func didChangeAuthInput(mailAddress: String, password: String)
}

/// 認証InteractorOutput
protocol AuthInteractorOutput: AnyObject {
    /// エラーメッセージを表示する
    /// - parameter message:エラーメッセージ
    func outputError(message: String)
}

/// 認証Usecase
protocol AuthUsecase: AnyObject {
    // Dependency
    var output: AuthInteractorOutput? { get }
    /// サインインする
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func signIn(mailAddress: String, password: String)

    /// 新規登録する
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func signUp(mailAddress: String, password: String)
}
