import Foundation

class PatienceAnalyzePresenter: PatienceAnalyzePresentation, PatienceAnalyzeOutput {
    // MARK: PatienceAnalyzePresentation
    var usecase: PatienceAnalyzeUsecase!

    var view: PatienceAnalyzeView?

    func didSelectMonth(year: Int, month: Int) {
        usecase.fetchDataFromMonth(year: year, month: month)
    }

    // MARK: PatienceAnalyzeOutput
    func outputFetchRecords(records: [PatienceEntity]) {
        view?.updateRecords(records: records)
        var sumMoney = 0
        records.forEach {
            sumMoney += $0.money
        }
        view?.updateSumMoney(sumMoney: sumMoney)
    }

    func outputError() {
        view?.showError(message: L10n.PatienceAnalyzePresenter.StatusNotification.Error.title)
    }
}
