import Foundation
import UIKit

/// 日付のピック方法を選べるdatePickerTextField
class SelectableDateStylePickerTextField: PatienceTextField {
    var selectedDate = DateForTractableDay() {
        didSet {
            text = selectedDate.dateString
        }
    }

    var isSingleDaySelect = true {
        didSet {
            selectedDate.isIncludeDate = isSingleDaySelect
            updatePickStyle()
        }
    }

    var dateChangeAction:((_ date: DateForTractableDay) -> Void)?

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
        selectedDate.isIncludeDate = isSingleDaySelect
        layer.cornerRadius = 4
        UIFont.boldSystemFont(ofSize: 20)
        backgroundColor = UIColor(hex: "F0E68C")
        textColor = UIColor.black
        textAlignment = .center

        setUpYearAndMonthPickerView()
        setUpDatePickerView()
        updatePickStyle()
    }

    private func setUpYearAndMonthPickerView() {
        yearAndMonthPickerView.delegate = self
        yearAndMonthPickerView.dataSource = self
        yearAndMonthPickerView.selectRow(DateForTractableDay().year - currentYear, inComponent: 0, animated: true)
        yearAndMonthPickerView.selectRow(DateForTractableDay().month - 1, inComponent: 1, animated: true)
        inputAccessoryView = keyboardToolbar
    }

    private func setUpDatePickerView() {
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.locale = .current
    }

    private func updatePickStyle() {
        if isSingleDaySelect {
            datePickerView.date = selectedDate.date
            inputView = datePickerView
        } else {
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
        if isSingleDaySelect {
            selectedDate.date = datePickerView.date
        }
        text = selectedDate.dateString
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
        let date = PaticuralDayFetcher.getBeginningMonth(year: year, month: month)
        selectedDate.date = date
    }
}
