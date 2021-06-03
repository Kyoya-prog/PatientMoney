import UIKit

/// DateUtilクラス
class DateUtils {
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

    static let dateFormatJapanese = "yyyy年MM月dd日"

    static func getStartDay(date: Date) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.startOfDay(for: date)
    }
}
