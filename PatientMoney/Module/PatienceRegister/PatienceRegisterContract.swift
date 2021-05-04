import Foundation
import RxSwift
import UIKit

struct Patience {
    var date: Date
    var description: String
    var money: Int
    var category: String
}

protocol PatienceInputWireframe {
    // Dependency
    var viewController: UIViewController? { get }

    ///  登録モーダルを閉じる
    func closeRegisterView()

    /// 更新Viewを閉じる
    func closeUpdateView()
}

protocol PatienceInputView {
    // Dependency
    var presenter: PatienceInputPresentation! { get }
    /// エラーメッセージを表示する
    /// - parameter message:エラーメッセージ
    func showError(message: String)

    /// 成功メッセージを表示する
    /// - parameter message:成功メッセージ
    func showSuccess(message: String)
}

protocol PatienceInputPresentation {
    // Dependency
    var view: PatienceInputView? { get }
    var interactor: PatienceUsecase! { get }
    var router: PatienceInputWireframe! { get }
    /// 登録ボタンがタップされた
    /// - parameter patience:登録項目
    func didTapRegisterButton(patience: Patience)

    /// 更新ボタンがタップされた
    /// - parameter patience:登録項目
    func didTapUpdateButton(patience: Patience)
}

protocol PatienceUsecase {
    // Dependency
    var output: PatienceInputInteractorOutput? { get }

    var repository: PatienceRepository! { get }
    /// データを登録する
    /// - parameter date:日付
    /// - parameter description:メモ
    /// - parameter money: 金額
    /// - parameter category: カテゴリー
    func registerPatienceData(date: Date, description: String, money: Int, category: String)

    /// データをupdateする
    /// - parameter record:データレコード
    func updatePatienceData(record: PatienceEntity)
}

protocol PatienceInputInteractorOutput {
    /// 登録時のエラーを知らせる
    /// - parameter error:エラー内容
    func outputRegisterError(error: Error)

    /// 登録に成功したことを知らせる
    func outputRegisterSuccess()

    /// 更新に成功したことを知らせる
    func outputUpdateSuccess()
}

protocol PatienceRepository {
    /// データを登録する
    /// - parameter data:ドキュメントデータ
    func registerPatienceData(data: [String: Any]) -> Error?

    /// データをフェッチする
    /// - parameter data:日付
    func fetchPatienceData(date: Date) -> Single<[PatienceEntity]>

    /// データをupdateする
    /// - parameter documentId:ドキュメントID
    /// - parameter record:データレコード
    func updatePatienceData(documentId: String, record: [String: Any]) -> Error?
}
