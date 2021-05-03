import Foundation
import UIKit

class DateView: UIView {
    /// 入力された日付
    var selectedDate: Date {
        get {
            DateUtils.dateFromString(string: dateTextField.text ?? "", format: DateUtils.dateFormatJapanese)
        }
        set {
            dateTextField.text = DateUtils.stringFromDate(date: newValue, format: DateUtils.dateFormatJapanese)
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

    // MARK: Private

    private func construct() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = L10n.DateView.title
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        addSubview(titleLabel)

        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.text = DateUtils.stringFromDate(date: Date(), format: DateUtils.dateFormatJapanese)
        dateTextField.backgroundColor = UIColor(hex: "F0E68C")
        dateTextField.textInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        dateTextField.font = UIFont.boldSystemFont(ofSize: 20)
        dateTextField.layer.cornerRadius = 4
        addSubview(dateTextField)

        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = .current

        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = keyboardToolbar

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 50),

            dateTextField.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            dateTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            dateTextField.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 20),
            dateTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -30)
        ])
    }

    private let datePicker = UIDatePicker()

    private let titleLabel = UILabel()

    private let dateTextField = PatienceTextField()

    private lazy var keyboardToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction(_:)))
        ]
        toolbar.sizeToFit()
        return toolbar
    }()

    @objc private func doneButtonAction(_ : UIBarButtonItem) {
        dateTextField.endEditing(true)

        let startDay = DateUtils.getStartDay(date: datePicker.date)
        selectedDate = startDay
        dateTextField.text = DateUtils.stringFromDate(date: startDay, format: DateUtils.dateFormatJapanese)
    }
}
