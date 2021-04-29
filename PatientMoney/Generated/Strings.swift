// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum AccountViewController {
    internal enum MailAddressLabel {
      /// メールアドレス
      internal static let text = L10n.tr("Localizable", "AccountViewController.MailAddressLabel.text")
    }
    internal enum MailAddressTextField {
      /// patience@example.com
      internal static let placeholder = L10n.tr("Localizable", "AccountViewController.MailAddressTextField.placeholder")
    }
    internal enum PasswordLabel {
      /// パスワード
      internal static let text = L10n.tr("Localizable", "AccountViewController.PasswordLabel.text")
    }
    internal enum PasswordTextField {
      /// patience123
      internal static let placeholder = L10n.tr("Localizable", "AccountViewController.PasswordTextField.placeholder")
    }
    internal enum SignIn {
      internal enum ChengeModeLabel {
        /// 新規登録画面へ移動
        internal static let text = L10n.tr("Localizable", "AccountViewController.SignIn.ChengeModeLabel.text")
      }
      internal enum DecideButton {
        /// ログインする
        internal static let title = L10n.tr("Localizable", "AccountViewController.SignIn.DecideButton.title")
      }
      internal enum TitleLabel {
        /// ログイン画面
        internal static let text = L10n.tr("Localizable", "AccountViewController.SignIn.TitleLabel.text")
      }
    }
    internal enum SignUp {
      internal enum ChangeModeLabel {
        /// ログイン画面へ移動
        internal static let text = L10n.tr("Localizable", "AccountViewController.SignUp.ChangeModeLabel.text")
      }
      internal enum DecideButton {
        /// 新規登録する
        internal static let title = L10n.tr("Localizable", "AccountViewController.SignUp.DecideButton.title")
      }
      internal enum TitleLabel {
        /// 新規登録画面
        internal static let text = L10n.tr("Localizable", "AccountViewController.SignUp.TitleLabel.text")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
