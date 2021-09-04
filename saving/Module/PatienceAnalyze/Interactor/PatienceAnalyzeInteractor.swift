import Foundation
import RxSwift

class PatienceAnalyzeInteractor: PatienceAnalyzeUsecase {
    var repository: PatienceRepository!

    var output: PatienceAnalyzeOutput?

    func fetchDataFromMonth(date: Date) {
        repository.fetchPatienceDataForMonth(date: date).subscribe { [weak self] observer in
            switch observer {
            case .success(let records):
                self?.output?.outputFetchRecords(records: records)

            case .error(_):
                self?.output?.outputError()
            }
        }.disposed(by: dispose)
    }

    func fetchDataFromDate(date: Date) {
        repository.fetchPatienceDataForDay(date: date).subscribe { [weak self] observer in
            switch observer {
            case .success(let records):
                self?.output?.outputFetchRecords(records: records)

            case .error(_):
                self?.output?.outputError()
            }
        }.disposed(by: dispose)
    }

    private let dispose = DisposeBag()
}
