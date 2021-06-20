import FirebaseFirestore.FIRTimestamp
import Foundation
import RxSwift

class PatienceAnalyzeInteractor: PatienceAnalyzeUsecase {
    var repository: PatienceRepository!

    var output: PatienceAnalyzeOutput?

    func fetchDataFromMonth(year: Int, month: Int) {
        let startDate = PaticuralDayFetcher.getBeginningMonth(year: year, month: month)
        let endDate = PaticuralDayFetcher.getEndMonth(year: year, month: month)
        repository.fetchPatienceData(startDate: startDate, endDate: endDate).subscribe { [weak self] observer in
            switch observer {
            case .success(let records):
                self?.output?.outputFetchRecords(records: records)

            case .failure(_):
                self?.output?.outputError()
            }
        }.disposed(by: dispose)
    }

    func fetchDataFromDate(date: Date) {
        repository.fetchPatienceData(date: date).subscribe { [weak self] observer in
            switch observer {
            case .success(let records):
                self?.output?.outputFetchRecords(records: records)

            case .failure(_):
                self?.output?.outputError()
            }
        }.disposed(by: dispose)
    }

    private let dispose = DisposeBag()
}
