//
//  SignupViewModelTests.swift
//  AjmeraTaskTests
//
//  Created by Vikram Kumar on 10/02/25.
//

import XCTest

final class SignupViewModelTests: XCTestCase {
    
    var viewModel: SignUpViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testEmptyFields_ShouldInvalidateInput() {
        Task { @MainActor in
            viewModel = SignUpViewModel()
            viewModel.fullname = ""
            viewModel.email = ""
            viewModel.password = ""
            viewModel.confirmPassword = ""
            XCTAssertFalse(viewModel.checkIsInputValid())
        }
    }
    
    func testInvalidEmail_ShouldInvalidateInput() {
        Task { @MainActor in
            viewModel = SignUpViewModel()
            viewModel.email = "invalidemail"
            XCTAssertFalse(viewModel.checkIsInputValid())
        }
    }
    
    func testPasswordMismatch_ShouldInvalidateInput() {
        Task { @MainActor in
            viewModel = SignUpViewModel()
            viewModel.password = "password123"
            viewModel.confirmPassword = "password321"
            XCTAssertFalse(viewModel.checkIsInputValid())
        }
    }
    
    func testUnderageUser_ShouldInvalidateInput() {
        Task { @MainActor in
            viewModel = SignUpViewModel()
            let underageBirthday = Calendar.current.date(byAdding: .year, value: -17, to: Date())!
            viewModel.birthday = underageBirthday
            XCTAssertFalse(viewModel.checkIsBirthdayValid())
        }
    }
    
    func testValidInput_ShouldValidateInput() {
        Task { @MainActor in
            viewModel = SignUpViewModel()
            viewModel.fullname = "John Doe"
            viewModel.email = "test@example.com"
            viewModel.password = "StrongPass123!"
            viewModel.confirmPassword = "StrongPass123!"
            viewModel.birthday = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
            viewModel.gender = "Male"
            XCTAssertTrue(viewModel.checkIsInputValid())
        }
    }
}
