import Foundation
import Moya

struct SignInTargetType: ApiTargetType {
    typealias Response = TokenEntity

    let email: String

    let password: String

    var parameters: [String: String] { ["email": email, "password": password] }

    var path: String { "/session" }

    var method: Moya.Method { .post }

    var sampleData: Data { Data() }

    var task: Task { .requestParameters(parameters: parameters, encoding: URLEncoding.default) }
}
