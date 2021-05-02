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
    
    @objc private func registerButtonAction(_ :UIButton){
        if let date = (subViews[0] as? DateView)?.selectedDate,
           let discription = (subViews[1] as? DescriptionView)?.memo,
           let money = (subViews[2] as? MoneyView )?.money,
           let category = (subViews[3] as? CategoriesView)?.selectedCategoryTitle
        {
            let patience = Patience(date: date, discription: discription, money: money, category: category)
            presenter.didTapRegisterButton(patience: patience)
        }
    }
}
