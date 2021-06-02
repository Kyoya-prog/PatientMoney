import Foundation
import UIKit.UIViewController

protocol PatienceAnalyzeUsecase:AnyObject{
    
    var repository:PatienceRepository!{ get }
    
    var output:PatienceAnalyzeOutput?{ get }
    
    /// 入力された年月のデータを取得する
    /// - parameter year:年
    /// - parameter month:月
    func fetchDataFromMonth(year:Int,month:Int)
}

protocol PatienceAnalyzeView:AnyObject{
    
    var presentation:PatienceAnalyzePresentation!{ get }
    
    /// 記録を更新する
    /// - parameter records:記録
    func updateRecords(records:[PatienceEntity])
    
    /// 合計金額を更新する
    /// - parameter sumMoney:合計金額
    func updateSumMoney(sumMoney:Int)
    
    /// エラーを表示する
    /// - parameter message:エラーメッセージ
    func showError(message:String)
}

protocol PatienceAnalyzePresentation:AnyObject{
    
    var usecase:PatienceAnalyzeUsecase!{get}
    var view:PatienceAnalyzeView?{get}
    
    /// 日付が変更された
    func didSelectMonth(year:Int,month:Int)
}

protocol PatienceAnalyzeOutput {
    
    /// 取得したデータを出力する
    /// - parameter records:記録
    func outputFetchRecords(records:[PatienceEntity])
    
    ///エラーを出力する
    func outputError()
}
