import Alamofire
import Foundation
import Moya

class ErrorMessageBuilder {
    static func buildErrorMessage(error: Error, message: String) -> String {
        guard let error = error as? MoyaResponseError else { return "処理に失敗しました" }
        switch error {
        case let .badRequestError(code):
            switch code {
            case 2000:
                return "既に使われているメールアドレスです"
            case 2001:
                return "パスワードが短すぎます。8文字以上入力してください"
            case 2002:
                return "正しいメールアドレスを入力してください"
            case 2003:
                return "メールアドレスまたはパスワードが間違っています"
            default:
                return message
            }

        case let .moyaError(error):
            if let error = ((error.errorUserInfo["NSUnderlyingError"]as? Alamofire.AFError)?.underlyingError as NSError?) {
                switch error.code {
                case -1009:
                    return message + "(インターネット接続がありません)"
                default:
                    return message
                }
            }

        case .unknownError:
            return message
        }
        return message
    }
    }
