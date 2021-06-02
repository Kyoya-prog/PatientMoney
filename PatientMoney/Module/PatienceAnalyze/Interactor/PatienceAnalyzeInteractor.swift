import Foundation
import FirebaseFirestore.FIRTimestamp
import RxSwift

class PatienceAnalyzeInteractor:PatienceAnalyzeUsecase{
    
    var repository: PatienceRepository!
    
    func fetchDataFromMonth(year: Int, month: Int) {
        let startDate = DateUtils.getBeginningMonth(year: year, month: month)
        let endDate = DateUtils.getEndMonth(year: year, month: month)
        let startTimestamp = Timestamp(date: startDate)
        let endTimestamp = Timestamp(date: endDate)
        repository.fetchPatienceData(startTimestamp: startTimestamp, endTimestamp: endTimestamp).subscribe { observer in
            switch observer{
            case .success(let records):
                print(records)
            case .failure(let error):
                print(error)
            }
        }.disposed(by: dispose)
    }
    
    private let dispose = DisposeBag()
}
