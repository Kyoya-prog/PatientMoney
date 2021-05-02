import Foundation
import UIKit

class DateView: UIView {
    /// 入力された日付
    var selectedDate: Date {
        get {
            DateUtils.dateFromString(string: dateTextField.text ?? "", format: dateFormat)
        }
        set {
            dateTextField.text = DateUtils.stringFromDate(date: newValue, format: dateFormat)
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
        dateTextField.placeholder = DateUtils.stringFromDate(date: Date(), format: dateFormat)
        dateTextField.backgroundColor = UIColor(hex: "F0E68C")
        dateTextField.textInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        dateTextField.font = UIFont.boldSystemFont(ofSize: 20)
        dateTextField.layer.cornerRadius = 4
        addSubview(dateTextField)

        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = .current

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction(_:)))
        toolBar.setItems([doneItem], animated: true)
        toolBar.sizeToFit()

        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolBar

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

    private let dateFormat = "yyyy年MM月dd日"

    @objc private func doneButtonAction(_ : UIBarButtonItem) {
        dateTextField.endEditing(true)

        dateTextField.text = DateUtils.stringFromDate(date: datePicker.date, format: dateFormat)
    }
}
