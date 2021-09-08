import Alamofire
import Foundation
import Moya

class ErrorMessageBuilder {
    static func buildErrorMessage(error: Error, message: String) -> String {
        if let error = (error as? MoyaError) {
            let apiError = checkMoyaError(error: error)
            return message + "(\(apiError.message))"
        }
        
        return message
    }
    
    private static func checkMoyaError(error: MoyaError) -> APIError {
        if let error = ((error.errorUserInfo["NSUnderlyingError"]as? Alamofire.AFError)?.underlyingError as NSError?) {
            switch error.code {
            case -1004:
                return .connectionError
                
            case -1009:
                return .networkError
                
            default:
                return .unknownError(error)
            }
        } else {
            switch error {
            case .objectMapping(_, _):
                return .badRequestError
                
            case .statusCode(_):
                return .serverError
                
            default:
                return .unknownError(error)
            }
        }
    }

    public enum APIError: Error {
        case connectionError
        case serverError
        case unknownError(_ error: Error)
        case networkError
        case badRequestError

        var message: String {
            switch self {
            case .connectionError:
                return "サーバーと通信できません。kyoyaprog@gmail.comまでお問い合わせください。"
            case .serverError:
                return "サーバーでエラーが発生しています。kyoyaprog@gmail.comまでお問い合わせください"
            case .unknownError:
                return "不明なエラーです"
            case .networkError:
                return "ネットワークに問題があります。接続状況を確認の上もう一度お試しください"
            case .badRequestError:
                return "不正なリクエストが検出されました"
            }
        }
    }
}
