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

    var selectedMonth: Int = 0 {
        didSet {
            monthLabel.text = "\(selectedMonth)月の合計節約額"
        }
    }

    var sumMoney: Int = 0 {
        didSet {
            sumMoneyLabel.text = "\(sumMoney)円"
        }
    }

    private func construct() {
        backgroundColor = .white

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = .black
        addSubview(titleLabel)

        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.font = UIFont.boldSystemFont(ofSize: 20)
        monthLabel.setContentHuggingPriority(.required, for: .horizontal)
        monthLabel.textColor = .black
        addSubview(monthLabel)

        sumMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        sumMoneyLabel.font = UIFont.boldSystemFont(ofSize: 20)
        sumMoneyLabel.textColor = .black
        addSubview(sumMoneyLabel)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            monthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            monthLabel.topAnchor.constraint(equalTo: topAnchor),

            sumMoneyLabel.leftAnchor.constraint(equalTo: monthLabel.rightAnchor, constant: 10),
            sumMoneyLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
    }

    private let titleLabel = UILabel()

    private let monthLabel = UILabel()

    private let sumMoneyLabel = UILabel()
}
