import Foundation
import UIKit

class DateView: PatienceInputViewComponent {
    /// 入力された日付
    var selectedDate: Date {
        get {
            DateStringConverter.dateFromString(string: dateTextField.text ?? "", format: DateStringConverter.dateFormatJapanese)
        }
        set {
            dateTextField.text = DateStringConverter.stringFromDate(date: newValue, format: DateStringConverter.dateFormatJapanese)
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

    override func resetView() {
        selectedDate = Date()
    }

    // MARK: Private

    private func construct() {
        print(Date())
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

    private let titleLabel = UILabel()

    private let dateTextField = SelectableDateStylePickerTextField()
}

extension DateView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        selectedDate = dateTextField.selectedDate
    }
}
