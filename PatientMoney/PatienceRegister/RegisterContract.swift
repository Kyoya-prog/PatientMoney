import Foundation
import UIKit

struct PatienceEntity{
    var date:Date
    var discription:String
    var money:Int
    var category:String
}

protocol RegisterWireframe{
    // Dependency
    var viewController: UIViewController? { get }
}

protocol RegisterView{
    // Dependency
    var presenter: RegisterPresentation! { get }
    /// エラーメッセージを表示する
    /// - parameter message:エラーメッセージ
    func showError(message: String)
}

protocol RegisterPresentation{
    // Dependency
    var view: RegisterView? { get }
    var interactor: RegisterUsecase! { get }
    var router: AuthWireFrame! { get }
    /// 登録ボタンがタップされた
    /// - parameter patience:登録項目
    func didTapRegisterButton(patience:PatienceEntity)
}

protocol RegisterUsecase{
    // Dependency
    var output: AuthInteractorOutput? { get }
    /// データを登録する
    /// - parameter date:日付
    /// - parameter discription:メモ
    /// - parameter money: 金額
    /// - parameter category: カテゴリー
    func registerPatienceData(date:Date,description:String,money:Int,category:String)
}

protocol RegisterInteractorOutput{
    /// 登録時のエラーを知らせる
    /// - parameter error:エラー内容
    func outputRegisterError(error:Error)
    
    /// 登録に成功したことを知らせる
    func outputRegisterSuccess()
    
}

protocol RegisterRepository{
    /// データを登録する
    /// - parameter date:日付
    /// - parameter discription:メモ
    /// - parameter money: 金額
    /// - parameter category: カテゴリー
    func registerPatienceData(date:Date,description:String,money:Int,category:String)
}
