import UIKit

/// Date⇆String変換クラス
class DateStringConverter {
    static func dateFromString(string: String, format: String) -> Date {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.date(from: string) ?? Date()
    }

    static func stringFromDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    static let dateFormatJapanese = "yyyy年MM月dd日"
    
    static let monthFotmatJapanese = "yyyy年MM月"
}

/// ある特定の日を取得するFetcherクラス
class PaticuralDayFetcher {
    static func getBeginningMonth(year: Int, month: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1

        // swiftlint:disable:next force_unwrapping
        let date = calendar.date(from: components)!
        return date
    }

    static func getEndMonth(year: Int, month: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = year
        components.month = month + 1
        components.day = 0

        // swiftlint:disable:next force_unwrapping
        let date = calendar.date(from: components)!
        return date
    }

    static func getStartDay(date: Date) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.startOfDay(for: date)
    }
}

/// 日付を含めるか含めないかで簡単に利用できるDateクラス
struct DateForTractableDay {
    var year: Int = Calendar.current.component(.year, from: Date())
    var month: Int = Calendar.current.component(.month, from: Date())
    var day: Int = Calendar.current.component(.day, from: Date())
    var date: Date {
        get {
            let calendar = Calendar(identifier: .gregorian)
            var components = DateComponents()
            components.year = year
            components.month = month
            components.day = day
            components.hour = 0
            components.minute = 0

            // swiftlint:disable:next force_unwrapping
            let date = calendar.date(from: components)!
            return date
        }
        set {
            let current = Calendar.current
            year = current.component(.year, from: newValue)
            month = current.component(.month, from: newValue)
            day = isIncludeDate ? current.component(.day, from: newValue):1
        }
    }
    var isIncludeDate = true {
        didSet {
            day = isIncludeDate ? Calendar.current.component(.day, from: date):1
        }
    }

    var dateString: String {
        // レイジープロパティでかくと、monthやyear、dayの値が初期値のままになるのでコンピューティッドプロパティで記述している
        // swiftlint:disable:next implicit_getter
        get {
            let formattedMonth = month < 10 ? "0\(month)" : "\(month)"
            if isIncludeDate {
                return "\(year)年\(formattedMonth)月\(day)日"
            } else {
                return "\(year)年\(formattedMonth)月"
            }
        }
    }
}
