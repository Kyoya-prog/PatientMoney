import FirebaseFirestore.FIRTimestamp
import Foundation
import RxSwift

class PatienceCalendarInteractor: PatienceCalendarUsecase {
    // MARK: PatienceCalendarUsecase
    var repository: PatienceRepository!

    var output: PatienceCalendarInteractorOutput?

    func fetchPatienceData(date: Date) {
        repository.fetchPatienceData(date: date)
            .subscribe { observer in
                switch observer {
                case .success(let records):
                    self.output?.outputFetchData(records: records)

                case .error(_):
                    self.output?.outputFetchError()
                }
            }.disposed(by: disposeBag)
    }

    func fetchDataFromMonth(year: Int, month: Int) {
        let startDate = PaticuralDayFetcher.getBeginningMonth(year: year, month: month)
        let endDate = PaticuralDayFetcher.getEndMonth(year: year, month: month)
        repository.fetchPatienceData(startDate: startDate, endDate: endDate).subscribe { [weak self]observer in
            switch observer {
            case .success(let records):
                self?.output?.outputFetchRecordsPerMonth(records: records)

            case .error(_):
                self?.output?.outputFetchError()
            }
        }.disposed(by: disposeBag)
    }

    func deletePatienceData(id: Int) {
        repository.deletePatienceData(id: id).subscribe { observer in
            switch observer {
            case .success(_):
                self.output?.notifyDeleteData()

            case .error(_):
                self.output?.outputDeleteError()
            }
        }.disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()
}
