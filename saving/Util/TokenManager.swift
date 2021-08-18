import Foundation
import KeychainAccess
import Moya

/// Oauthのトークンを管理するManagerクラス
class TokenManager {
    static func setToken(token: String) {
        try? keychain.remove("access-token")
        try? keychain.set(token, key: "access-token")
    }

    static func getToken() -> String {
        let token = try? keychain.get("access-token")
        return token ?? ""
    }

    static func isLogin() -> Bool {
        var isLogin = false
        let semaphore = DispatchSemaphore(value: 0)
        // semaphoreでメインスレッドを止めて待ち合わせているのでバックグラウンドスレッドで実行するようにする
        ApiClient.shared.request(CheckTokenTargetType(), callbackQueue: .global(qos: .default)) { result in
            switch result {
            case .success(_):
                isLogin = true

            default:
                break
            }
            semaphore.signal()
        }

        switch semaphore.wait(timeout: .now() + 2.0) {
        case .success:
            return isLogin

        case .timedOut:
            return false
        }
    }

    private static let keychain = Keychain()
}
