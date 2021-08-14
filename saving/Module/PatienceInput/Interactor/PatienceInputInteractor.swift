import Foundation
import RxSwift

class PatienceInputInteractor: PatienceUsecase {
    var output: PatienceInputInteractorOutput?

    var repository: PatienceRepository!

    func updatePatienceData(record: PatienceEntity) {
        let documentData = ["Date": record.date, "Memo": record.memo, "Money": record.money, "Category": record.categoryTitle, "UID": uid] as [String: Any]
        repository.updatePatienceData(id: record.documentID, record: documentData).subscribe { observer in
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
        let documentData = ["Date": record.date, "Memo": record.memo, "Money": record.money, "Category": record.categoryTitle, "UID": uid] as [String: Any]
        repository.registerPatienceData(data: documentData).subscribe { observer in
            switch observer {
            case .success(_):
                self.output?.outputInputSuccess()

            case .error(let error):
                self.output?.outputInputError(error: error)
            }
        }
        .disposed(by: disposeBag)
    }

    private var uid: String = {
        FirebaseAuthManeger.shared.uid
    }()

    private let disposeBag = DisposeBag()
}
