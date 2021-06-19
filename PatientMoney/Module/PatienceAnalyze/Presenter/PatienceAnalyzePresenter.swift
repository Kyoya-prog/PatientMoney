import Foundation

class PatienceAnalyzePresenter: PatienceAnalyzePresentation, PatienceAnalyzeOutput {
    // MARK: PatienceAnalyzePresentation
    var usecase: PatienceAnalyzeUsecase!

    var view: PatienceAnalyzeView?

    func didChangeDate(dateModel: DateForTractableDay, isSingleDaySelect: Bool) {
        if isSingleDaySelect {
            usecase.fetchDataFromDate(date: dateModel.date)
        } else {
            usecase.fetchDataFromMonth(year: dateModel.year, month: dateModel.month)
        }
    }

    // MARK: PatienceAnalyzeOutput
    func outputFetchRecords(records: [PatienceEntity]) {
        let models = translatePatienceEntityIntoModel(records: records)
        view?.updateCharts(data: models)
    }

    func outputError() {
        view?.showError(message: L10n.PatienceAnalyzePresenter.StatusNotification.Error.title)
    }

    private func translatePatienceEntityIntoModel(records: [PatienceEntity]) -> [PatienceChartDataModel] {
        let model = records.map { PatienceChartDataModel(categoryTilte: $0.categoryTitle, money: $0.money) }
        return model
    }
}
