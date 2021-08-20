import Foundation
import RxSwift

class PatienceInputInteractor: PatienceUsecase {
    var output: PatienceInputInteractorOutput?

    var repository: PatienceRepository!

    func updatePatienceData(record: PatienceEntity) {
        repository.updatePatienceData(record: record).subscribe { observer in
            switch observer {
            case .success(_):
                self.output?.outputInputSuccess()

            case .error(let error):
                self.output?.outputInputError(error: error)
            }
        }
        .disposed(by: disposeBag)
    }

    func registerPatienceData(record: PatienceEntity) {
        repository.registerPatienceData(record: record).subscribe { observer in
            switch observer {
            case .success(_):
                self.output?.outputInputSuccess()

            case .error(let error):
                self.output?.outputInputError(error: error)
            }
        }
        .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()
}
