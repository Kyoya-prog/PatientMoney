import Foundation
import Moya

struct PatiencePerMonthTargetType: ApiTargetType {
    typealias Response = PatiencesEntity

    let startDate: Date

    let endDate: Date

    var path: String { "/patiences/per_month" }

    var method: Moya.Method { .get }

    var sampleData: Data { Data() }

    var task: Task { .requestParameters(parameters:
                                            ["start_date": startDate, "end_date": endDate], encoding: URLEncoding.queryString) }
}
