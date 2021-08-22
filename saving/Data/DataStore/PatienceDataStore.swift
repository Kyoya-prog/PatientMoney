import Foundation
import RxSwift

class PatienceDataStore: PatienceRepository {
    func registerPatienceData(record: PatienceEntity) -> Single<PatienceEntity> {
        Single.create { observer -> Disposable in
            ApiClient.shared.request(CreatePatienceTargetType(registeredAt: record.registeredAt, money: record.money, memo: record.memo ?? "", categoryTitle: record.categoryTitle)) { result in
                switch result {
                case let .success(record):
                    observer(.success(record))

                case let .failure(error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func fetchPatienceData(date: Date) -> Single<[PatienceEntity]> {
        Single.create { observer -> Disposable in
            ApiClient.shared.request(PatiencePerDateTargetType(date: date)) { result in
                switch result {
                case let .success(record):
                    observer(.success(record.patiences))

                case let .failure(error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func fetchPatienceData(startDate: Date, endDate: Date) -> Single<[PatienceEntity]> {
        Single.create { observer -> Disposable in
            ApiClient.shared.request(PatiencePerMonthTargetType(startDate: startDate, endDate: endDate)) { result in
                switch result {
                case let .success(record):
                    observer(.success(record.patiences))

                case let .failure(error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func updatePatienceData(record: PatienceEntity) -> Single<PatienceEntity> {
        Single.create { observer -> Disposable in
            ApiClient.shared.request(UpdatePatienceTargetType(registeredAt: record.registeredAt, money: record.money, memo: record.memo, categoryTitle: record.categoryTitle, id: record.id)) { result in
                switch result {
                case let .success(record):
                    observer(.success(record))

                case let .failure(error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func deletePatienceData(id: Int) ->Single<Void> {
        Single.create { observer -> Disposable in
            ApiClient.shared.request(DeletePatienceTargetType(id: id)) { result in
                switch result {
                case .success(_):
                    observer(.success(Void()))

                case let .failure(error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
