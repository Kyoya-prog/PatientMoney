import Foundation
import Moya

struct PatiencePerDateTargetType: ApiTargetType {
    typealias Response = PatiencesEntity

    let date: Date

    var path: String { "/patiences/per_day" }

    var method: Moya.Method { .get }

    var sampleData: Data { Data() }

    var task: Task { .requestParameters(parameters:
                                            ["date": date], encoding: URLEncoding.queryString) }
}
