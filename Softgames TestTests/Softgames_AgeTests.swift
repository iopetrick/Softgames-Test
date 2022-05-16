//
//  Softgames_AgeTests.swift
//  Softgames TestTests
//
//  Created by Pratikkumar Prajapati on 16/05/22.
//

import XCTest
@testable import Softgames_Test

class Softgames_AgeTests: XCTestCase {
    
    func test_age_with_empty_String() {
        let delegate = TestUserFormViewModelDelegate()
        let sut = getNewViewModel(delegate: delegate)
        let dateString = ""
        sut.showUserAge(date: dateString)
        XCTAssertTrue(delegate.isErrorCalled)
        XCTAssert(delegate.fullName.isEmpty)
        XCTAssert(delegate.age.isEmpty)
        XCTAssertEqual(delegate.errorMessage, "Invalid Date of birth. Please add valid date.")
    }
    
    func test_age_with_valid_String() {
        let expectation = expectation(description: "Should return  valid number")
        let delegate = TestUserFormViewModelDelegate()
        let sut = getNewViewModel(delegate: delegate)
        let dateString = "2012/05/30"
        sut.showUserAge(date: dateString)
        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
            XCTAssertFalse(delegate.isErrorCalled)
            XCTAssert(delegate.fullName.isEmpty)
            XCTAssertEqual(delegate.age, "9")
            XCTAssertEqual(delegate.errorMessage, "")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test_age_with_wrong_String() {
        let delegate = TestUserFormViewModelDelegate()
        let sut = getNewViewModel(delegate: delegate)
        let dateString = "20/05/2030"
        sut.showUserAge(date: dateString)
        
        XCTAssertTrue(delegate.isErrorCalled)
        XCTAssert(delegate.fullName.isEmpty)
        XCTAssertEqual(delegate.age, "")
        XCTAssertEqual(delegate.errorMessage, "Invalid Date of birth. Please add valid date.")
        
    }
}

extension Softgames_AgeTests {
    func getNewViewModel(delegate: UserFormViewModelDelegate) -> UserFormViewModel {
        let viewModel = UserFormViewModel(delegate: delegate)
        return viewModel
    }
}
