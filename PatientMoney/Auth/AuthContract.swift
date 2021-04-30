import Foundation
import UIKit.UIViewController

/// 認証Wireframe
protocol AuthWireFrame: AnyObject {
    // Dependency
    var viewController: UIViewController? { get }

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
}

/// 認証Presentation
protocol AuthPresentation: AnyObject {
    // Dependency
    var view: AuthView? { get }
    var interactor: AuthUsecase! { get }
    var router: AuthWireFrame! { get }

    /// ログイン、新規登録ボタンが押された
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func didTapFinishButton(mailAddress: String, password: String)

    /// アカウントの入力状態が変化した
    /// - parameter mailAddress:メールアドレス
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
