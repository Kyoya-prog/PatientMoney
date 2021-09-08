import Foundation
import Moya

struct SignUpTargetType: ApiTargetType {
    typealias Response = TokenEntity

    var path: String { "/users" }

    var method: Moya.Method { .post }

    var sampleData: Data { Data() }

    var task: Task { .requestPlain }
}
