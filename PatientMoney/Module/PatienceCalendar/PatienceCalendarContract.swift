import UIKit

protocol PatienceCalendarWireframe {
    // Dependency
    var viewController: UIViewController? { get }

    /// 登録画面を表示する
    /// - parameter date:日付
    func presentRegisterModal(date: Date)

    /// 更新画面を表示する
    /// - parameter record:登録データ
    func presentUpdateView(record: PatienceRecord)
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

    /// 記録配列を更新する
    /// - parameter records:記録
    func updateRecord(records: [PatienceRecord])
}

protocol PatienceCalendarPresentation {
    // Dependency
    var view: PatienceCalendarView? { get }
    var interactor: PatienceCalendarUsecase! { get }
    var router: PatienceCalendarWireframe! { get }

    /// 登録ボタンがタップされた
    /// - parameter date:日付
    func didTapRegisterButton(date: Date)

    /// 記録セルがタップされた
    /// - parameter record:記録
    func didTappedRecordCell(record: PatienceRecord)

    /// 日付が変更された
    /// - parameter date:日付
    func dateDidchange(date: Date)
}

protocol PatienceCalendarUsecase {
    // Dependency
    var repository: PatienceRepository! { get }
    /// データをフェッチする
    /// - parameter data:日付
    func fetchPatienceData(date: Date)
}

protocol PatienceCalendarInteractorOutput {
    /// フェッチしてきたデータを表示する
    /// - parameter records:フェッチされた記録
    func outputFetchData(records: [PatienceRecord])

    /// エラーを返す
    func outputError()
}
