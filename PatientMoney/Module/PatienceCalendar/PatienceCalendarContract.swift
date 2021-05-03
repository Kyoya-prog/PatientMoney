import UIKit

protocol PatienceCalendarWireframe {
    // Dependency
    var viewController: UIViewController? { get }

    /// 登録画面を表示する
    /// - parameter date:日付
    func presentRegisterModal(date: Date)

    /// 項目を更新する
    /// - parameter record:登録してあるデータ
    func presentUpdatePatienceView(record: PatienceRecord)
}

protocol PatienceCalendarView {
    // Dependency
    var presenter: PatienceCalendarPresentation! { get }
    /// エラーメッセージを表示する
    /// - parameter message:エラーメッセージ
    func showError(message: String)

    /// 成功メッセージを表示する
    /// - parameter message:成功メッセージ
    func showSuccess(message: String)
}

protocol PatienceCalendarPresentation {
    // Dependency
    var view: PatienceInputView? { get }
    var interactor: PatienceUsecase! { get }
    var router: PatienceCalendarWireframe! { get }
    /// 登録ボタンがタップされた
    /// - parameter patience:登録項目
    func didTapRegisterButton(patience: Patience)
}
