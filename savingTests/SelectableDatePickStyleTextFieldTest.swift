//
//  SelectableDatePickStyleTextFieldTest.swift
//  PatientMoneyTests
//
//  Created by 松山響也 on 2021/06/18.
//

@testable import saving
import XCTest

class SelectableDatePickStyleTextFieldTest: XCTestCase {
    private var date = Date()

    override func setUpWithError() throws {
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = 2000
        components.month = 2
        components.day = 28

        // swiftlint:disable:next force_unwrapping
        date = calendar.date(from: components)!
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCorrectTextDisplayWhenIsSingleSelect() {
        let dateTextField = SelectableDateStylePickerTextField()
        dateTextField.selectedDate = date
        XCTAssertEqual(dateTextField.text, "2000年02月28日")
    }

    func testCorrectTextDisplayWhenNotIsSingleSelect() {
        let dateTextField = SelectableDateStylePickerTextField()
        dateTextField.isSingleDaySelect = false
        dateTextField.selectedDate = date
        XCTAssertEqual(dateTextField.text, "2000年02月")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
