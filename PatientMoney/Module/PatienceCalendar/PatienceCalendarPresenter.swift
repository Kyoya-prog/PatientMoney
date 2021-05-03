import Foundation

class PatienceCalendarPresenter: PatienceCalendarPresentation, PatienceCalendarInteractorOutput {
    var view: PatienceCalendarView?
    var interactor: PatienceCalendarUsecase!
    var router: PatienceCalendarWireframe!

    func didTapRegisterButton(date: Date) {
        router.presentRegisterModal(date: date)
    }

    func didTappedRecordCell(record: PatienceRecord) {
        router.presentUpdateView(record: record)
    }

    func dateDidchange(date: Date) {
        interactor.fetchPatienceData(date: DateUtils.getStartDay(date: date))
    }

    func outputFetchData(records: [PatienceRecord]) {
        view?.updateRecord(records: records)
    }

    func outputError() {
        view?.showError(message: "データの取得に失敗しました")
    }
}
