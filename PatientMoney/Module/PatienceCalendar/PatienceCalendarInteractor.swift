import Foundation

class PatienceCalendarInteractor: PatienceCalendarUsecase {
    var repository: PatienceRepository!
    var output: PatienceCalendarInteractorOutput?

    func fetchPatienceData(date: Date) {
        repository.fetchPatienceData(date: date) { result in
            switch result {
            case .success(let records):
                self.output?.outputFetchData(records: records)

            case .failure:
                self.output?.outputError()
            }
        }
    }
}
