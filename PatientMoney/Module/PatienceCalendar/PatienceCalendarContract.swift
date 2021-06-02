import UIKit

protocol PatienceCalendarWireframe {
    // Dependency
    var viewController: UIViewController? { get }

    /// 登録画面を表示する
    /// - parameter date:日付
    func presentRegisterModal(date: Date)

    /// 更新画面を表示する
    /// - parameter record:登録データ
    func presentUpdateView(record: PatienceEntity)
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
    func updateRecord(records: [PatienceEntity])

    /// 記録が削除された
    func didDeleteRecord()
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
    func didTapRecordCell(record: PatienceEntity)

    /// セルの削除ボタンがタップされた
    /// - parameter documentId:ドキュメントID
    func didTapDeleteButton(documentId: String)

    /// 日付が変更された
    /// - parameter date:日付
    func selectedDateDidChange(date: Date)
}

protocol PatienceCalendarUsecase {
    // Dependency
    var repository: PatienceRepository! { get }
    /// データをフェッチする
    /// - parameter data:日付
    func fetchPatienceData(date: Date)

    /// データを削除する
    /// - parameter documentId:ドキュメントID
    func deletePatienceData(documentId: String)
}

protocol PatienceCalendarInteractorOutput {
    /// フェッチしてきたデータを表示する
    /// - parameter records:フェッチされた記録
    func outputFetchData(records: [PatienceEntity])

    /// データが消去されたことを通知する
    func notifyDeleteData()

    /// フェッチの際のエラーを返す
    func outputFetchError()

    /// データ削除の際のエラーを返す
    func outputDeleteError()
}
