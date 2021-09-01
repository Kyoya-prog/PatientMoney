import Foundation
import UIKit

/// 日付のピック方法を選べるdatePickerTextField
class SelectableDateStylePickerTextField: PatienceTextField {
    var selectedDate = Date().zeroClock {
        didSet {
            if isSingleDaySelect {
                text = selectedDate.getDateText(format: DateStringConverter.dateFormatJapanese)
            } else {
                text = selectedDate.getDateText(format: DateStringConverter.monthFormatJapanese)
            }
        }
    }

    var isSingleDaySelect = true {
        didSet {
            updateDisplay()
        }
    }

    var dateChangeAction:((_ date: Date) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        construct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }

    private func construct() {
        font = UIFont.boldSystemFont(ofSize: 20)
        text = DateStringConverter.stringFromDate(date: Date(), format: "yyyy年　M月")
        layer.cornerRadius = 4
        UIFont.boldSystemFont(ofSize: 20)
        backgroundColor = UIColor(hex: "F0E68C")
        textColor = UIColor.black
        textAlignment = .center

        setUpYearAndMonthPickerView()
        setUpDatePickerView()
        updateDisplay()
    }

    private func setUpYearAndMonthPickerView() {
        yearAndMonthPickerView.delegate = self
        yearAndMonthPickerView.dataSource = self
        yearAndMonthPickerView.selectRow(Date().year - currentYear, inComponent: 0, animated: true)
        yearAndMonthPickerView.selectRow(Date().month - 1, inComponent: 1, animated: true)
        inputAccessoryView = keyboardToolbar
    }

    private func setUpDatePickerView() {
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.locale = Locale(identifier: "en_US_POSIX")
    }

    private func updateDisplay() {
        if isSingleDaySelect {
            text = selectedDate.getDateText(format: DateStringConverter.dateFormatJapanese)
            datePickerView.date = selectedDate
            inputView = datePickerView
        } else {
            text = selectedDate.getDateText(format: DateStringConverter.monthFormatJapanese)
            inputView = yearAndMonthPickerView
        }
        dateChangeAction?(selectedDate)
    }

    private lazy var years: [Int] = { (2000...currentYear).reversed().map { $0 } }()

    private let months = (1...12).map { $0 }

    private let yearAndMonthPickerView = UIPickerView()

    private let datePickerView = UIDatePicker()

    private lazy var keyboardToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction(_:)))
        ]
        toolbar.sizeToFit()
        return toolbar
    }()

    private lazy var currentYear: Int = {
        guard let currentYear = Int(DateStringConverter.stringFromDate(date: Date(), format: "yyyy")) else {
            return  2000
        }
        return currentYear
    }()

    @objc private func doneButtonAction(_ : UIBarButtonItem) {
        selectedDate = datePickerView.date.zeroClock
        endEditing(true)
        dateChangeAction?(selectedDate)
    }

    // 入力カーソル非表示
    override func caretRect(for position: UITextPosition) -> CGRect {
        CGRect.zero
    }

    // 範囲選択カーソル非表示
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        []
    }

    // コピー・ペースト・選択等のメニュー非表示
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }
}

// MARK: - UIPickerViewDelegate,UIPickerViewDataSource
extension SelectableDateStylePickerTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return years.count
        } else if component == 1 {
            return months.count
        } else {
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(years[row])年"
        } else if component == 1 {
            return "\(months[row])月"
        } else {
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let year = years[pickerView.selectedRow(inComponent: 0)]
        let month = months[pickerView.selectedRow(inComponent: 1)]
        var date = Date()
        date.year = year
        date.month = month
        selectedDate = date.beginMonth
    }
}
