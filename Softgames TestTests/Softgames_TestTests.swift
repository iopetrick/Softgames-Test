//
//  Softgames_TestTests.swift
//  Softgames TestTests
//
//  Created by Pratikkumar Prajapati on 16/05/22.
//

import XCTest
@testable import Softgames_Test

class Softgames_TestTests: XCTestCase {
    
    func test_ViewModel_with_No_first_last_data() {
        let delegate = TestUserFormViewModelDelegate()
        let sut = getNewViewModel(delegate: delegate)
        let data: [String: String?]? = nil
        sut.getDataFrom(dictionary: data)
        XCTAssertTrue(delegate.isErrorCalled)
        XCTAssert(delegate.fullName.isEmpty)
        XCTAssert(delegate.age.isEmpty)
        XCTAssertEqual(delegate.errorMessage, "First and last name is mendatory. Please input missing values.")
    }

    func test_ViewModel_with_empty_string_data() {
        let delegate = TestUserFormViewModelDelegate()
        let sut = getNewViewModel(delegate: delegate)
        let data: [String: String?]? = [
            "first_name": "",
            "last_name": "",
        ]
        sut.getDataFrom(dictionary: data)
        XCTAssertTrue(delegate.isErrorCalled)
        XCTAssert(delegate.fullName.isEmpty)
        XCTAssert(delegate.age.isEmpty)
        XCTAssertEqual(delegate.errorMessage, "First and last name is mendatory. Please input missing values.")
    }
    
    func test_ViewModel_with_wrong_object() {
        let delegate = TestUserFormViewModelDelegate()
        let sut = getNewViewModel(delegate: delegate)
        let data: [String: String?]? = [
            "name_first": "Abc",
            "name_last": "Xyz",
        ]
        sut.getDataFrom(dictionary: data)
        XCTAssertTrue(delegate.isErrorCalled)
        XCTAssert(delegate.fullName.isEmpty)
        XCTAssert(delegate.age.isEmpty)
        XCTAssertEqual(delegate.errorMessage, "First and last name is mendatory. Please input missing values.")
    }
    
    func test_ViewModel_with_only_first_name() {
        let delegate = TestUserFormViewModelDelegate()
        let sut = getNewViewModel(delegate: delegate)
        let data: [String: String?]? = [
            "first_name": "Abc",
        ]
        sut.getDataFrom(dictionary: data)
        XCTAssertTrue(delegate.isErrorCalled)
        XCTAssert(delegate.fullName.isEmpty)
        XCTAssert(delegate.age.isEmpty)
        XCTAssertEqual(delegate.errorMessage, "First and last name is mendatory. Please input missing values.")
    }
    
    func test_ViewModel_with_only_last_name() {
        let delegate = TestUserFormViewModelDelegate()
        let sut = getNewViewModel(delegate: delegate)
        let data: [String: String?]? = [
            "last_name": "Abc",
        ]
        sut.getDataFrom(dictionary: data)
        XCTAssertTrue(delegate.isErrorCalled)
        XCTAssert(delegate.fullName.isEmpty)
        XCTAssert(delegate.age.isEmpty)
        XCTAssertEqual(delegate.errorMessage, "First and last name is mendatory. Please input missing values.")
    }
    
    func test_ViewModel_with_valid_data() {
        let delegate = TestUserFormViewModelDelegate()
        let sut = getNewViewModel(delegate: delegate)
        let data: [String: String?]? = [
            "first_name": "Abc",
            "last_name": "Xyz",
        ]
        sut.getDataFrom(dictionary: data)
        XCTAssertFalse(delegate.isErrorCalled)
        XCTAssertEqual("Abc Xyz", delegate.fullName)
        XCTAssert(delegate.age.isEmpty)
        XCTAssertEqual(delegate.errorMessage, "")
    }
}

extension Softgames_TestTests {
    func getNewViewModel(delegate: UserFormViewModelDelegate) -> UserFormViewModel {
        let viewModel = UserFormViewModel(delegate: delegate)
        return viewModel
    }
}


class TestUserFormViewModelDelegate: UserFormViewModelDelegate {
    
    var isErrorCalled: Bool = false
    var fullName: String = ""
    var age: String = ""
    var errorMessage: String = ""
    
    func showError(message: String) {
        isErrorCalled = true
        errorMessage = message
    }
    
    func sendFullName(fullName: String) {
        self.fullName = fullName
    }
    
    func sendUserAge(age: String) {
        self.age = age
    }
}
