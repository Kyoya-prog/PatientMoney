import Foundation
import Moya

struct PatiencePerMonthTargetType: ApiTargetType {
    typealias Response = PatiencesEntity

    let date: Date

    var path: String { "/patiences/per_month" }

    var method: Moya.Method { .get }

    var sampleData: Data { Data() }

    var task: Task { .requestParameters(parameters:
                                            ["date": date], encoding: URLEncoding.queryString) }
}
