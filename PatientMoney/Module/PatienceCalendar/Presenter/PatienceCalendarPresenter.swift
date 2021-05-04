import Foundation

class PatienceCalendarPresenter: PatienceCalendarPresentation, PatienceCalendarInteractorOutput {
    var view: PatienceCalendarView?
    var interactor: PatienceCalendarUsecase!
    var router: PatienceCalendarWireframe!

    func didTapRegisterButton(date: Date) {
        router.presentRegisterModal(date: date)
    }

    func didTapRecordCell(record: PatienceEntity) {
        router.presentUpdateView(record: record)
    }

    func selectedDateDidChange(date: Date) {
        interactor.fetchPatienceData(date: DateUtils.getStartDay(date: date))
    }

    func outputFetchData(records: [PatienceEntity]) {
        view?.updateRecord(records: records)
    }

    func outputError() {
        view?.showError(message: "データの取得に失敗しました")
    }
}
