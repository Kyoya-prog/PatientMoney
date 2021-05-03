import Foundation
import UIKit

struct Patience {
    var date: Date
    var description: String
    var money: Int
    var category: String
}

protocol PatienceRegisterWireframe {
    // Dependency
    var viewController: UIViewController? { get }
}

protocol PatienceRegisterView {
    // Dependency
    var presenter: PatienceRegisterPresentation! { get }
    /// エラーメッセージを表示する
    /// - parameter message:エラーメッセージ
    func showError(message: String)

    /// 成功メッセージを表示する
    /// - parameter message:成功メッセージ
    func showSuccess(message: String)
}

protocol PatienceRegisterPresentation {
    // Dependency
    var view: PatienceRegisterView? { get }
    var interactor: PatienceUsecase! { get }
    var router: AuthWireFrame! { get }
    /// 登録ボタンがタップされた
    /// - parameter patience:登録項目
    func didTapRegisterButton(patience: Patience)
}

protocol PatienceUsecase {
    // Dependency
    var output: PatienceRegisterInteractorOutput? { get }

    var repository: PatienceRepository! { get }
    /// データを登録する
    /// - parameter date:日付
    /// - parameter description:メモ
    /// - parameter money: 金額
    /// - parameter category: カテゴリー
    func registerPatienceData(date: Date, description: String, money: Int, category: String)

    /// データをフェッチする
    /// - parameter data:日付
    func fetchPatienceData(date: Date)

    /// データをupdateする
    /// - parameter record:データレコード
    func updatePatienceData(record: PatienceRecord)
}

protocol PatienceRegisterInteractorOutput {
    /// 登録時のエラーを知らせる
    /// - parameter error:エラー内容
    func outputRegisterError(error: Error)

    /// 登録に成功したことを知らせる
    func outputRegisterSuccess()
}

protocol PatienceRepository {
    /// データを登録する
    /// - parameter data:ドキュメントデータ
    func registerPatienceData(data: [String: Any]) -> Error?

    /// データをフェッチする
    /// - parameter data:日付
    func fetchPatienceData(date: Date) -> Result<[PatienceRecord], Error>

    /// データをupdateする
    /// - parameter documentId:ドキュメントID
    /// - parameter record:データレコード
    func updatePatienceData(documentId: String, record: [String: Any]) -> Error?
}
