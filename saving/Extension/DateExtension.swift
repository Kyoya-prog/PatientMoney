import Foundation
//swiftlint:disable unused_setter_value

extension Date {
    init(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) {
        self.init(
            timeIntervalSince1970: Date().fixed(
                year: year,
                month: month,
                day: day,
                hour: hour,
                minute: minute,
                second: second
            ).timeIntervalSince1970
        )
    }

    func fixed(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date {
        let calendar = self.calendar

        var comp = DateComponents()
        comp.year   = year ?? calendar.component(.year, from: self)
        comp.month  = month ?? calendar.component(.month, from: self)
        comp.day    = day ?? calendar.component(.day, from: self)
        comp.hour   = hour ?? calendar.component(.hour, from: self)
        comp.minute = minute ?? calendar.component(.minute, from: self)
        comp.second = second ?? calendar.component(.second, from: self)
        //swiftlint:disable:next force_unwrapping
        return calendar.date(from: comp)!
    }

    var year: Int {
        get {calendar.component(.year, from: self)
        }
        set {
        }
    }

    var month: Int {
        get {calendar.component(.month, from: self)
        }
        set {
        }
    }

    var day: Int {
        get {calendar.component(.day, from: self)
        }
        set {
        }
    }

    var hour: Int {
        calendar.component(.hour, from: self)
    }

    var minute: Int {
        calendar.component(.minute, from: self)
    }

    var second: Int {
        calendar.component(.second, from: self)
    }

    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .japan
        calendar.locale   = .japan
        return calendar
    }

    var zeroClock: Date {
        fixed(hour: 0, minute: 0, second: 0)
    }

    var beginMonth: Date {
        fixed(day: 1, hour: 0, minute: 0, second: 0)
    }

    var endMonth: Date {
        fixed(month: month + 1, day: 0, hour: 0, minute: 0, second: 0)
    }

    func getDateText(format: String) -> String {
        DateStringConverter.stringFromDate(date: self, format: format)
    }
}
