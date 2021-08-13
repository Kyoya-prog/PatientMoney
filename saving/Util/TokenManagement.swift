import Foundation
import KeychainAccess

/// Oauthのトークンを管理するManagementクラス
class TokenManagement {
    static let shared = TokenManagement()

    func setToken(token: String) {
        try? keychain.remove("access-token")
        try? keychain.set("token", key: "access-token")
    }

    func getToken() -> String? {
        let token = try? keychain.get("access-token")
        return token
    }

    private let keychain = Keychain()

    private init() {}
}
