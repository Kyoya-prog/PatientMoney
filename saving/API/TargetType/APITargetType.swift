import Foundation
import Moya

///　デフォルト実装を用意し、レスポンスの型を定義できるようにしたTargetType
protocol ApiTargetType: TargetType {
    associatedtype Response: Decodable
}

extension ApiTargetType {
    //swiftlint:disable:next force_unwrapping
    var baseURL: URL { URL(string: "https://saving-kyoya.jp")! }
    var headers: [String: String]? {
        let token = TokenManagement.getToken()
       return  ["Content-Type": "application/json", "Authorization": "Token \(token)"]
    }
}
