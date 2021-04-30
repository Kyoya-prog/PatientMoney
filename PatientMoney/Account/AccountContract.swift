import Foundation

protocol AccountView: AnyObject {
    /// エラーメッセージを表示する
    /// - parameter message:エラーメッセージ
    func outputError(message: String)
}

protocol AccountPresentation: AnyObject {
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

protocol AccountInteractor: AnyObject {
    /// サインインする
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func signIn(mailAddress: String, password: String)

    /// 新規登録する
    /// - parameter mailAddress:メールアドレス
    /// - parameter password:パスワード
    func signUp(mailAddress: String, password: String)
}
