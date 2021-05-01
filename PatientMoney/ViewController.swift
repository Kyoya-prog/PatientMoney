//
//  ViewController.swift
//  PatientMoney
//
//  Created by 松山響也 on 2021/04/25.
//

import Firebase
import FirebaseFirestore
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "home"
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
