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

    static let monthFormatJapanese = "yyyy年MM月"
}
