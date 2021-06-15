import Foundation
import RxSwift

class PatienceInputInteractor: PatienceUsecase {
    var output: PatienceInputInteractorOutput?

    var repository: PatienceRepository!

    func updatePatienceData(record: PatienceEntity) {
        let documentData = ["Date": record.date, "Memo": record.memo, "Money": record.money, "Category": record.categoryTitle, "UID": uid] as [String: Any]
        repository.updatePatienceData(documentId: record.documentID, record: documentData).subscribe { observer in
            switch observer {
            case .success(_):
                self.output?.outputRegisterSuccess()

            case .failure(let error):
                self.output?.outputRegisterError(error: error)
            }
        }
        .disposed(by: disposeBag)
    }

    func registerPatienceData(date: Date, memo: String, money: Int, category: String) {
        let documentData = ["Date": date, "Memo": memo, "Money": money, "Category": category, "UID": uid] as [String: Any]
        repository.registerPatienceData(data: documentData).subscribe { observer in
            switch observer {
            case .success(_):
                self.output?.outputRegisterSuccess()

            case .failure(let error):
                self.output?.outputRegisterError(error: error)
            }
        }
        .disposed(by: disposeBag)
    }

    private var uid: String = {
        FirebaseAuthManeger.shared.uid
    }()

    private let disposeBag = DisposeBag()
}
