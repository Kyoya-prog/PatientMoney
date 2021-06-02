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
                    self.output?.outputFetchError()
                }
            }.disposed(by: disposeBag)
    }

    func deletePatienceData(documentId: String) {
        repository.deletePatienceData(documentId: documentId).subscribe { observer in
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
