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
