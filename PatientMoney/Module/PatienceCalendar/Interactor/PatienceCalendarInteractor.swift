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

                case .failure:
                    self.output?.outputFetchError()
                }
            }.disposed(by: disposeBag)
    }

    func fetchDataFromMonth(year: Int, month: Int) {
        let startDate = DateUtils.getBeginningMonth(year: year, month: month)
        let endDate = DateUtils.getEndMonth(year: year, month: month)
        let startTimestamp = Timestamp(date: startDate)
        let endTimestamp = Timestamp(date: endDate)
        repository.fetchPatienceData(startTimestamp: startTimestamp, endTimestamp: endTimestamp).subscribe { [weak self]observer in
            switch observer {
            case .success(let records):
                self?.output?.outputFetchRecordsPerMonth(records: records)

            case .failure(_):
                self?.output?.outputFetchError()
            }
        }.disposed(by: disposeBag)
    }

    func deletePatienceData(id: String) {
        repository.deletePatienceData(id: id).subscribe { observer in
            switch observer {
            case .success(_):
                self.output?.notifyDeleteData()

            case .failure(_):
                self.output?.outputDeleteError()
            }
        }.disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()
}
