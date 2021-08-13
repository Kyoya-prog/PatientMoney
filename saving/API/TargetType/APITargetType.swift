import Foundation
import Moya

///　デフォルト実装を用意し、レスポンスの型を定義できるようにしたTargetType
protocol ApiTargetType: TargetType {
    associatedtype Response: Codable
}

extension ApiTargetType {
    //swiftlint:disable:next force_unwrapping
    var baseURL: URL { URL(string: "https://saving-kyoya.jp")! }
    var headers: [String: String]? { ["Content-Type": "application/json"] }
}

