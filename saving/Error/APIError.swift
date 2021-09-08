import Foundation

enum APIError: Error {
    case connectionError
    case serverError
    case unknownError(_ error: Error)
    case networkError
    case badRequestError

    var message: String {
        switch self {
        case .connectionError:
            return L10n.ApiError.connectionError

        case .serverError:
            return L10n.ApiError.serverError

        case .unknownError:
            return L10n.ApiError.unknownError

        case .networkError:
            return L10n.ApiError.networkError

        case .badRequestError:
            return L10n.ApiError.badRequestError
        }
    }
}
