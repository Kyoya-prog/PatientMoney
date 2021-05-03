import Foundation
import RxSwift

class PatienceCalendarInteractor: PatienceCalendarUsecase {
    var repository: PatienceRepository!
    var output: PatienceCalendarInteractorOutput?

    func fetchPatienceData(date: Date) {
        repository.fetchPatienceData(date: date)
            .subscribe { observer in
                switch observer {
                case .success(let records):
                    self.output?.outputFetchData(records: records)

                case .failure:
                    self.output?.outputError()
                }
            }.disposed(by: self.disposeBag)
    }

    private let disposeBag = DisposeBag()
}
