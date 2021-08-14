import Alamofire
import Foundation
import Moya

class ErrorMessageBuilder {
    static func buildErrorMessage(error: Error, message: String) -> String {
        var errorMessage = message
        // NSError型を得るためMoyaErrorの中のNSUnderlyingErrorを抽出し、NSErrorにキャスト
        if let moyaError = error as? MoyaError, let error = ((moyaError.errorUserInfo["NSUnderlyingError"]as? Alamofire.AFError)?.underlyingError as NSError?) {
            switch error.code {
            case -1009: // NSURLErrorNotConnectedToInternet　（ネットワーク接続エラーの場合は、その趣旨をエラーメッセージの後につける）
                errorMessage = message + "(インターネット接続がありません)"
            default:
                errorMessage = message
            }
        }
        return errorMessage
    }

    static func buildAuthErrorMessage(error: Error) -> String {
        guard let error = error as? MoyaResponseError else { return "処理に失敗しました" }
        switch error {
        case let .badRequestError(code):
            switch code {
            case 2000:
                return "既に使われているメールアドレスです"
            case 2001:
                return "パスワードが短すぎます"
            case 2002:
                return "正しいメールアドレスを入力してください"
            case 2003:
                return "メールアドレスまたはパスワードが間違っています"
            default:
                return "処理に失敗しました"
            }

        case let .moyaError(error):
            if let error = ((error.errorUserInfo["NSUnderlyingError"]as? Alamofire.AFError)?.underlyingError as NSError?) {
                switch error.code {
                case -1009:
                    return ""
                default:
                    return "処理に失敗しました"
                }
            }

        case .unknownError:
            return "処理に失敗しました"
        }
        return "処理に失敗しました"
    }
}
