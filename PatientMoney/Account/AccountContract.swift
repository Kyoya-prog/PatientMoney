import Foundation
import UIKit.UIViewController

protocol AccountWireFrame: AnyObject {
    // Dependency
    var viewController: UIViewController? { get }

    /// Home画面を表示する
    func presentHomeView()
}

protocol AccountView: AnyObject {
    // Dependency
    var presenter: AccountPresentation { get }
    /// エラーメッセージを表示する
    /// - parameter message:エラーメッセージ
    func outputError(message: String)
}

protocol AccountPresentation: AnyObject {
    // Dependency
    var view: AccountView? { get }
    var interactor: AccountUsecase! { get }
    var router: AccountWireFrame! { get }

    /// ログイン、新規登録ボタンが押された
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func didTapFinishButton(mailAddress: String, password: String)

    /// アカウントの入力状態が変化した
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func didChangeAccountInput(mailAddress: String, password: String)
}

protocol AccountInteractorOutput: AnyObject {
    /// エラーメッセージを表示する
    /// - parameter message:エラーメッセージ
    func outputError(message: String)
}

protocol AccountUsecase: AnyObject {
    // Dependency
    var output: AccountInteractorOutput? { get }
    /// サインインする
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func signIn(mailAddress: String, password: String)

    /// 新規登録する
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func signUp(mailAddress: String, password: String)
}
