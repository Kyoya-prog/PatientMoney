import FirebaseFirestore.FIRTimestamp
import Foundation
import RxSwift

class PatienceAnalyzeInteractor: PatienceAnalyzeUsecase {
    var repository: PatienceRepository!

    var output: PatienceAnalyzeOutput?

    func fetchDataFromMonth(year: Int, month: Int) {
        let startDate = DateUtils.getBeginningMonth(year: year, month: month)
        let endDate = DateUtils.getEndMonth(year: year, month: month)
        let startTimestamp = Timestamp(date: startDate)
        let endTimestamp = Timestamp(date: endDate)
        repository.fetchPatienceData(startTimestamp: startTimestamp, endTimestamp: endTimestamp).subscribe { [weak self]observer in
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
