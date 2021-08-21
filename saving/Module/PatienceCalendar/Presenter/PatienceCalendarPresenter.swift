import Foundation

class PatienceCalendarPresenter: PatienceCalendarPresentation, PatienceCalendarInteractorOutput {
    // MARK: PatienceCalendarInteractorOutput
    var view: PatienceCalendarView?

    var interactor: PatienceCalendarUsecase!

    var router: PatienceCalendarWireframe!

    func didTapRegisterButton(date: Date) {
        router.presentRegisterModal(date: date)
    }

    func didTapRecordCell(record: PatienceEntity) {
        router.presentUpdateView(record: record)
    }

    func didTapDeleteButton(id: Int) {
        interactor.deletePatienceData(id: id)
    }

    func selectedDateDidChange(date: Date) {
        interactor.fetchPatienceData(date: date.zeroclock)
        interactor.fetchDataFromMonth(date: date)
    }

    func outputFetchData(records: [PatienceEntity]) {
        view?.updateRecord(records: records)
    }

    func notifyDeleteData() {
        view?.didDeleteRecord()
    }

    func outputFetchError() {
        view?.showError(message: "データの取得に失敗しました")
    }

    func outputDeleteError() {
        view?.showError(message: "データの消去に失敗しました")
    }

    func outputFetchRecordsPerMonth(records: [PatienceEntity]) {
        calculateSumMoney(records: records)
    }

    private func calculateSumMoney(records: [PatienceEntity]) {
        var sumMoney = 0
        records.forEach {
            sumMoney += $0.money
        }
        view?.updateSumMoney(sumMoney: sumMoney)
    }
}
