import Foundation
import UIKit

class RegisterViewController: UIViewController, RegisterView {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = L10n.RegisterViewController.RegisterButton.title
        view.backgroundColor = .white
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.axis = .vertical
        vstack.alignment = .fill
        vstack.distribution = .equalSpacing
        subViews.forEach {
            vstack.addArrangedSubview($0)
            let border = UIView()
            border.backgroundColor = UIColor(hex: "DCDCDC")
            border.heightAnchor.constraint(equalToConstant: 1).isActive = true
            vstack.addArrangedSubview(border)
        }
        view.addSubview(vstack)

        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle(L10n.RegisterViewController.RegisterButton.title, for: .normal)
        registerButton.backgroundColor = .orange
        registerButton.layer.cornerRadius = 10
        registerButton.addTarget(self, action: #selector(registerButtonAction(_:)), for: .touchUpInside)
        view.addSubview(registerButton)

        NSLayoutConstraint.activate([
            vstack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            vstack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            vstack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            vstack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),

            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            registerButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }

    // MARK: RegisterView
    var presenter: RegisterPresentation!

    func showError(message: String) {
        StatusNotification.notifyError(message)
    }

    func showSuccess(message: String) {
        StatusNotification.notifySuccess(message)
    }

    // MARK: Private

    private let vstack = UIStackView()

    private let subViews = [
        DateView(),
        DescriptionView(),
        MoneyView(),
        CategoriesView()
    ]

    private let registerButton = UIButton()

    private lazy var alert: UIAlertController = {
        let alert = UIAlertController(title: nil, message: L10n.RegisterViewController.Alert.title, preferredStyle: .alert)
        let okAction = UIAlertAction(title: L10n.RegisterViewController.Alert.OkAction.title, style: .default, handler: { [weak self] _ in
            self?.registerAction()
        })
        let cancelAction = UIAlertAction(title: L10n.RegisterViewController.Alert.CancelAction.title, style: .cancel, handler: { [weak self] _ in
            self?.cancelAction()
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        return alert
    }()

    private func registerAction() {
    }

    private func cancelAction() {
    }

    @objc private func registerButtonAction(_ :UIButton) {
        if let date = (subViews[0] as? DateView)?.selectedDate,
           let description = (subViews[1] as? DescriptionView)?.memo,
           let category = (subViews[3] as? CategoriesView)?.selectedCategoryTitle {
            if let money = (subViews[2] as? MoneyView)?.money {
                let patience = Patience(date: date, description: description, money: money, category: category)
                presenter.didTapRegisterButton(patience: patience)
            } else {
                present(alert, animated: true, completion: nil)
            }
        }
    }
}
