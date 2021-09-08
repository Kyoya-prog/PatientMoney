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


}
