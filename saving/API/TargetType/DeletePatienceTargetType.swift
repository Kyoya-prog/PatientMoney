import Foundation
import Moya

struct DeletePatienceTargetType: ApiTargetType {
    typealias Response = SimpleEntity

    let id: Int

    var path: String { "/patiences/\(id)" }

    var method: Moya.Method { .delete }

    var sampleData: Data { Data() }

    var task: Task { .requestPlain }
}
