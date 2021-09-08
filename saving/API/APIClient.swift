import Foundation
import Moya

protocol ApiClientInterface {
    func request<T: ApiTargetType>(_ request: T, callbackQueue: DispatchQueue, completion: @escaping (Result<T.Response, MoyaResponseError>) -> Void)
}

class ApiClient: ApiClientInterface {
    private init() {}

    static let shared = ApiClient()

    func request<T>(_ request: T, callbackQueue: DispatchQueue = .main, completion: @escaping (Result<T.Response, MoyaResponseError>) -> Void) where T: ApiTargetType {
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
                if let model = try? response.map(T.Response.self, using: decoder) {
                    completion(.success(model))
                } else if let errorModel = try? response.map(ErrorResponse.self) {
                    completion(.failure(.badRequestError(errorModel.code)))
                } else {
                        completion(.failure(.unknownError))
                    }

            case let .failure(moyaError):
                completion(.failure(.moyaError(moyaError)))
            }
        }
    }
}

struct ErrorResponse: Decodable {
    var code: Int
    var message: String
}

enum MoyaResponseError: Error {
    case moyaError(Moya.MoyaError)
    case badRequestError(Int)
    case unknownError
}
