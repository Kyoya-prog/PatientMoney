import Alamofire
import Foundation
import Moya

class ErrorMessageBuilder {
    static func buildErrorMessage(error: Error, message: String) -> String {
        guard let error = error as? MoyaResponseError else { return message }
        switch error {
        case let .badRequestError(code):
            switch code {
            case 2000:
                return L10n.ErrorMessageBuilder.takenMailAddress
            case 2001:
                return L10n.ErrorMessageBuilder.passwordTooShort
            case 2002:
                return L10n.ErrorMessageBuilder.takenMailAddress
            case 2003:
                return L10n.ErrorMessageBuilder.userNotFound
            default:
                return message
            }

        case let .moyaError(error):
            if let error = ((error.errorUserInfo["NSUnderlyingError"]as? Alamofire.AFError)?.underlyingError as NSError?) {
                switch error.code {
                case -1009:
                    return message + L10n.ErrorMessageBuilder.SubMessage.cannotConnectNetwork
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
