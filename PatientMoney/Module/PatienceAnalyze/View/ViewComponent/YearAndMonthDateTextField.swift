import Foundation
import UIKit

class YearAndMonthDateTextField: PatienceTextField {
    var selectedMonth: Int = 1

    var selectedYear: Int = 2000

    var didSelectAction:((_ selectedMonth: Int, _ selectedYear: Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        construct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }

    private func construct() {
        text = DateUtils.stringFromDate(date: Date(), format: "yyyy年　M月")
        layer.cornerRadius = 4
        UIFont.boldSystemFont(ofSize: 20)
        backgroundColor = UIColor(hex: "F0E68C")
        textAlignment = .center

        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        inputView = pickerView
        inputAccessoryView = keyboardToolbar
    }

    private lazy var years: [Int] = { (2000...currentYear).reversed().map { $0 } }()

    private let months = (1...12).map { $0 }

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
        endEditing(true)
        didSelectAction?(selectedMonth, selectedYear)
    }
}

// MARK: - UIPickerViewDelegate,UIPickerViewDataSource
extension YearAndMonthDateTextField: UIPickerViewDelegate, UIPickerViewDataSource {
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
        text = "\(year)年 \(month)月"
    }
}
