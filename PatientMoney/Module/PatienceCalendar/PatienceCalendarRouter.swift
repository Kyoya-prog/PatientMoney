//
//  PatienceCalenderRouter.swift
//  PatientMoney
//
//  Created by 松山響也 on 2021/05/03.
//

import Foundation
import UIKit.UIViewController

class PatienceCalendarRouter: PatienceCalendarWireframe {
    var viewController: UIViewController?

    func presentRegisterModal(date: Date) {
        let registerView = PatienceInputRouter.assembleRegisterModule(date: date)
        viewController?.navigationController?.pushViewController(registerView, animated: true)
    }

    func presentUpdateView(record: PatienceRecord) {
        let updateView = PatienceInputRouter.assembleUpdateModule(record: record)
        viewController?.present(updateView, animated: true, completion: nil)
    }
}
