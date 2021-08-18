import Foundation
import Moya

struct CheckTokenTargetType: ApiTargetType {
    typealias Response = CheckTokenEntity

    var path: String { "/session/check" }

    var method: Moya.Method { .get }

    var sampleData: Data { Data() }

    var task: Task { .requestPlain }
}

struct CheckTokenEntity: Decodable {
    var result: String
}
