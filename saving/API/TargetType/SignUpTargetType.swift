import Foundation
import Moya

struct SignUpTargetType: ApiTargetType {
    typealias Response = OAuthTokenEntity

    let email: String

    let password: String
    
    var parameters: [String: String] { ["email": email, "password": password] }

    var path: String { "/users" }

    var method: Moya.Method { .post }

    var sampleData: Data

    var task: Task { .requestParameters(parameters: parameters, encoding: URLEncoding.default) }
}
