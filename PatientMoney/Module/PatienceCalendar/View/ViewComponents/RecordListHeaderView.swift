//
//  RecordListHeaderView.swift
//  PatientMoney
//
//  Created by 松山響也 on 2021/05/15.
//

import Foundation
import UIKit

/// 記録リストHeaderView
class RecordListHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        construct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }

    ///　taitoru
    var title: String = ""{
        didSet {
            titleLabel.text = title
        }
    }

    private func construct() {
        backgroundColor = .white

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = .black
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 44),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private let titleLabel = UILabel()
}
