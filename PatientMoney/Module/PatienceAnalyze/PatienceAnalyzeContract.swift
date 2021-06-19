import Foundation
import UIKit.UIViewController

protocol PatienceAnalyzeUsecase: AnyObject {
    var repository: PatienceRepository! { get }

    var output: PatienceAnalyzeOutput? { get }

    /// 指定年月のデータを取得する
    /// - parameter year:年
    /// - parameter month:月
    func fetchDataFromMonth(year: Int, month: Int)

    /// 指定日時のデータを取得する
    /// - parameter date:日付
    func fetchDataFromDate(date: Date)
}

protocol PatienceAnalyzeView: AnyObject {
    var presentation: PatienceAnalyzePresentation! { get }

    /// チャートを更新する
    /// - parameter records:記録
    func updateCharts(records: [PatienceChartDataModel])

    /// エラーを表示する
    /// - parameter message:エラーメッセージ
    func showError(message: String)
}

protocol PatienceAnalyzePresentation: AnyObject {
    var usecase: PatienceAnalyzeUsecase! { get }
    var view: PatienceAnalyzeView? { get }

    /// 日付が変更された
    /// - parameter date:選択されている日付
    func didChangeDate(date: DateForTractableDay)
}

protocol PatienceAnalyzeOutput {
    /// 取得したデータを出力する
    /// - parameter records:記録
    func outputFetchRecords(records: [PatienceEntity])

    ///エラーを出力する
    func outputError()
}
