import Foundation
import Moya

protocol ApiClientInterface {
    func request<T: ApiTargetType>(_ request: T, callbackQueue: DispatchQueue, completion: @escaping (Result<T.Response, Error>) -> Void)
}

class ApiClient: ApiClientInterface {
    private init() {}

    static let shared = ApiClient()

    func request<T>(_ request: T, callbackQueue: DispatchQueue = .main, completion: @escaping (Result<T.Response, Error>) -> Void) where T: ApiTargetType {
        let provider = MoyaProvider<T>()
        provider.request(request, callbackQueue: callbackQueue) { result in
            let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                formatter.calendar = Calendar(identifier: .iso8601)
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                formatter.locale = Locale(identifier: "en_US_POSIX")
                return formatter
            }()
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            switch result {
            case let .success(response):
                do {
                    let model = try response.filterSuccessfulStatusCodes().map(T.Response.self)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

struct ErrorResponse: Decodable {
    var code: Int
    var message: String
}
