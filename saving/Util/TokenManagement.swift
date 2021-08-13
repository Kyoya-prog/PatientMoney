import Foundation
import KeychainAccess

/// Oauthのトークンを管理するManagementクラス
class TokenManagement {

    static func setToken(token: String) {
        try? keychain.remove("access-token")
        try? keychain.set("token", key: "access-token")
    }

    static func getToken() -> String {
        let token = try? keychain.get("access-token")
        return token ?? ""
    }

    private static let keychain = Keychain()
}
