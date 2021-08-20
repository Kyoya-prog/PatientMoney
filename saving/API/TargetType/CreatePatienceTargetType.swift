import Foundation
import Moya

struct CreatePatienceTargetType: ApiTargetType {
    typealias Response = PatienceEntity

    let registeredAt: Date

    let money: Int

    let memo: String

    let categoryTitle: String

    var parameters: [String: Any] { ["money": money, "memo": memo, "category_title": categoryTitle, "registered_at": registeredAt] }

    var path: String { "/patiences" }

    var method: Moya.Method { .post }

    var sampleData: Data { Data() }

    var task: Task { .requestParameters(parameters: parameters, encoding: URLEncoding.queryString) }
}
