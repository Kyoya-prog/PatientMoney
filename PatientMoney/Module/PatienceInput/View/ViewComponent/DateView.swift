import Foundation
import UIKit

class DateView: UIView {
    /// 入力された日付
    var selectedDate: Date {
        get {
            DateAndStringConverter.dateFromString(string: dateTextField.text ?? "", format: DateAndStringConverter.dateFormatJapanese)
        }
        set {
            dateTextField.text = DateAndStringConverter.stringFromDate(date: newValue, format: DateAndStringConverter.dateFormatJapanese)
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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = UIColor.black
        addSubview(titleLabel)

        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.delegate = self
        addSubview(dateTextField)

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

    private let dateTextField = SelectableDatePickStyleTextField()
}

extension DateView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        selectedDate = dateTextField.selectedDate.date
    }
}
