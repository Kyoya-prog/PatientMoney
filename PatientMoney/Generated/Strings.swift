// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum AppDelegate {
    internal enum HomeView {
      internal enum CalendarView {
        /// カレンダー
        internal static let title = L10n.tr("Localizable", "AppDelegate.HomeView.CalendarView.title")
      }
      internal enum RegisterView {
        /// 登録
        internal static let title = L10n.tr("Localizable", "AppDelegate.HomeView.RegisterView.title")
      }
    }
  }

  internal enum AuthViewController {
    /// パスワードは8文字以上入力してください。
    internal static let passwordMustMoreEightCharacters = L10n.tr("Localizable", "AuthViewController.passwordMustMoreEightCharacters")
    internal enum MailAddressLabel {
      /// メールアドレス
      internal static let text = L10n.tr("Localizable", "AuthViewController.MailAddressLabel.text")
    }
    internal enum MailAddressTextField {
      /// patience@example.com
      internal static let placeholder = L10n.tr("Localizable", "AuthViewController.MailAddressTextField.placeholder")
    }
    internal enum PasswordLabel {
      /// パスワード
      internal static let text = L10n.tr("Localizable", "AuthViewController.PasswordLabel.text")
    }
    internal enum PasswordTextField {
      /// patience123
      internal static let placeholder = L10n.tr("Localizable", "AuthViewController.PasswordTextField.placeholder")
    }
    internal enum SignIn {
      internal enum ChangeDesctiptionLabel {
        /// アカウントを持っていない場合
        internal static let text = L10n.tr("Localizable", "AuthViewController.SignIn.ChangeDesctiptionLabel.text")
      }
      internal enum ChangeViewLabel {
        /// 登録はこちら
        internal static let text = L10n.tr("Localizable", "AuthViewController.SignIn.ChangeViewLabel.text")
      }
      internal enum DecideButton {
        /// ログインする
        internal static let title = L10n.tr("Localizable", "AuthViewController.SignIn.DecideButton.title")
      }
      internal enum TitleLabel {
        /// ログイン画面
        internal static let text = L10n.tr("Localizable", "AuthViewController.SignIn.TitleLabel.text")
      }
    }
    internal enum SignUp {
      internal enum ChangeDesctiptionLabel {
        /// すでにアカウントを持っている場合
        internal static let text = L10n.tr("Localizable", "AuthViewController.SignUp.ChangeDesctiptionLabel.text")
      }
      internal enum ChangeViewLabel {
        /// ログイン
        internal static let text = L10n.tr("Localizable", "AuthViewController.SignUp.ChangeViewLabel.text")
      }
      internal enum DecideButton {
        /// 新規登録する
        internal static let title = L10n.tr("Localizable", "AuthViewController.SignUp.DecideButton.title")
      }
      internal enum TitleLabel {
        /// 新規登録画面
        internal static let text = L10n.tr("Localizable", "AuthViewController.SignUp.TitleLabel.text")
      }
    }
  }

  internal enum CategoriesView {
    /// カテゴリー
    internal static let title = L10n.tr("Localizable", "CategoriesView.title")
  }

  internal enum CategoryIcon {
    internal enum Title {
      /// 交通費
      internal static let bus = L10n.tr("Localizable", "CategoryIcon.Title.bus")
      /// 趣味
      internal static let paintBrush = L10n.tr("Localizable", "CategoryIcon.Title.paintBrush")
      /// 飲食費
      internal static let pizzaSlice = L10n.tr("Localizable", "CategoryIcon.Title.pizzaSlice")
    }
  }

  internal enum DateView {
    /// 日付
    internal static let title = L10n.tr("Localizable", "DateView.title")
  }

  internal enum FirebaseAuthManager {
    internal enum Error {
      internal enum Default {
        /// 認証に失敗しました。もう一度お試しください。
        internal static let message = L10n.tr("Localizable", "FirebaseAuthManager.Error.Default.message")
      }
      internal enum EmailAlreadyInUse {
        /// このメールアドレスはすでに使用されています。
        internal static let message = L10n.tr("Localizable", "FirebaseAuthManager.Error.EmailAlreadyInUse.message")
      }
      internal enum InvalidEmail {
        /// メールアドレスの形式が不正です。
        internal static let message = L10n.tr("Localizable", "FirebaseAuthManager.Error.InvalidEmail.message")
      }
      internal enum UserNotFound {
        /// ユーザーが見つかりませんでした。
        internal static let message = L10n.tr("Localizable", "FirebaseAuthManager.Error.UserNotFound.message")
      }
      internal enum WrongPassword {
        /// パスワードが間違っています。
        internal static let message = L10n.tr("Localizable", "FirebaseAuthManager.Error.WrongPassword.message")
      }
    }
  }

  internal enum MemoView {
    /// メモ
    internal static let title = L10n.tr("Localizable", "MemoView.title")
    internal enum MemoTextView {
      /// 未入力
      internal static let text = L10n.tr("Localizable", "MemoView.MemoTextView.text")
    }
  }

  internal enum MoneyView {
    /// 金額
    internal static let title = L10n.tr("Localizable", "MoneyView.title")
  }

  internal enum PatienceCalendarViewController {
    internal enum NavigationItem {
      /// カレンダー
      internal static let title = L10n.tr("Localizable", "PatienceCalendarViewController.NavigationItem.title")
    }
  }

  internal enum PatienceInputPresenter {
    internal enum StatusNotification {
      internal enum Failure {
        /// 登録に失敗しました
        internal static let title = L10n.tr("Localizable", "PatienceInputPresenter.StatusNotification.Failure.title")
      }
      internal enum Success {
        /// 登録に成功しました
        internal static let title = L10n.tr("Localizable", "PatienceInputPresenter.StatusNotification.Success.title")
      }
    }
  }

  internal enum PatienceInputViewController {
    internal enum Alert {
      /// 金額が０円ですがこのまま登録しますか？
      internal static let title = L10n.tr("Localizable", "PatienceInputViewController.Alert.title")
      internal enum CancelAction {
        /// キャンセル
        internal static let title = L10n.tr("Localizable", "PatienceInputViewController.Alert.CancelAction.title")
      }
      internal enum OkAction {
        /// OK
        internal static let title = L10n.tr("Localizable", "PatienceInputViewController.Alert.OkAction.title")
      }
    }
    internal enum InputButton {
      internal enum Register {
        /// 登録する
        internal static let title = L10n.tr("Localizable", "PatienceInputViewController.InputButton.Register.title")
      }
      internal enum Update {
        /// 更新する
        internal static let title = L10n.tr("Localizable", "PatienceInputViewController.InputButton.Update.title")
      }
    }
    internal enum NavigationItem {
      /// 登録画面
      internal static let title = L10n.tr("Localizable", "PatienceInputViewController.NavigationItem.title")
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
