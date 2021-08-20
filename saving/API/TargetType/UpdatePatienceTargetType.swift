import Foundation
import Moya

struct UpdatePatienceTargetType: ApiTargetType {
    typealias Response = PatienceEntity

    let registeredAt: Date

    let money: Int

    let memo: String?

    let categoryTitle: String

    let id: Int

    var parameters: [String: Any] { ["money": money, "memo": memo ?? "", "category_title": categoryTitle, "registered_at": registeredAt] }

    var path: String { "/patience/\(id)" }

    var method: Moya.Method { .post }

    var sampleData: Data { Data() }

    var task: Task { .requestParameters(parameters: parameters, encoding: URLEncoding.queryString) }
}
