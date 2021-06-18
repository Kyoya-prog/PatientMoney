import Foundation
import UIKit

/// 日付のピック方法を選べるdatePickerTextField
class SelectableDatePickStyleTextField: PatienceTextField {
    var selectedMonth: Int = 1 {
        didSet {
            updateText()
        }
    }

    var selectedYear: Int = 2000 {
        didSet {
            updateText()
        }
    }

    var selecetdDate = Date() {
        didSet {
            updateText()
        }
    }

    var isSingleDaySelect = true {
        didSet {
            updatePickStyle()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        construct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }

    private func construct() {
        setUpYearAndMonthPickerView()
        setUpDatePickerView()
        updatePickStyle()
    }

    private func setUpYearAndMonthPickerView() {
        font = UIFont.boldSystemFont(ofSize: 20)
        text = DateUtils.stringFromDate(date: Date(), format: "yyyy年　M月")
        selectedMonth = Int(DateUtils.stringFromDate(date: Date(), format: "M")) ?? 1
        selectedYear = Int(DateUtils.stringFromDate(date: Date(), format: "yyyy")) ?? 2000
        layer.cornerRadius = 4
        UIFont.boldSystemFont(ofSize: 20)
        backgroundColor = UIColor(hex: "F0E68C")
        textColor = UIColor.black
        textAlignment = .center

        yearAndMonthPickerView.delegate = self
        yearAndMonthPickerView.dataSource = self
        inputView = yearAndMonthPickerView
        inputAccessoryView = keyboardToolbar
    }

    private func setUpDatePickerView() {
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.locale = .current
    }

    private func updatePickStyle() {
        inputView = isSingleDaySelect ? datePickerView : yearAndMonthPickerView
    }

    private lazy var years: [Int] = { (2000...currentYear).reversed().map { $0 } }()

    private let months = (1...12).map { $0 }

    private let yearAndMonthPickerView = UIPickerView()

    private let datePickerView = UIDatePicker()

    private func updateText() {
        if isSingleDaySelect {
        text = DateUtils.stringFromDate(date: selecetdDate, format: DateUtils.dateFormatJapanese)
        } else {
        text = "\(selectedYear)年 \(selectedMonth)月"
        }
    }

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
        guard let currentYear = Int(DateUtils.stringFromDate(date: Date(), format: "yyyy")) else {
            return  2000
        }
        return currentYear
    }()

    @objc private func doneButtonAction(_ : UIBarButtonItem) {
        selecetdDate = datePickerView.date
        updateText()
        endEditing(true)
    }
}

// MARK: - UIPickerViewDelegate,UIPickerViewDataSource
extension SelectableDatePickStyleTextField: UIPickerViewDelegate, UIPickerViewDataSource {
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
        selectedMonth = month
        selectedYear = year
        selecetdDate = DateUtils.getBeginningMonth(year: selectedYear, month: selectedMonth)
        text = "\(year)年 \(month)月"
    }
}
