import XCTest
@testable import PromiseKit
@testable import ProfileTableViewController
@testable import CustomDropDown
@testable import InsuranceApp

class InsuranceAppTests: XCTestCase {
    
    var loginView : LoginView?
    
    override func setUpWithError() throws {
        loginView = LoginView()
        loginView?.initializeLoginView()
    }
    
    override func tearDownWithError() throws {
        loginView = nil
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLoginView() throws {
        XCTAssertNotNil(loginView, "View not initialzed")
        
        let username = loginView?.usernameView.infoTextField.text
        let usernamePlaceHolder = loginView?.usernameView.infoTextField.placeholder
        XCTAssertNotNil(username)
        XCTAssertEqual(usernamePlaceHolder, "Enter username")
        
        let password = loginView?.passwordView.infoTextField.text
        let passwordPlaceHolder = loginView?.passwordView.infoTextField.placeholder
        XCTAssertNotNil(password)
        XCTAssertEqual(passwordPlaceHolder, "Enter password")
        
        let isHiddenError = loginView?.loginErrorLabel.isHidden
        XCTAssertEqual(isHiddenError, true)
        
        let errorMessage = loginView?.loginErrorLabel.text
        XCTAssertEqual(errorMessage, "LOGIN ERROR!!!!!!!")
        
        let signInButtonLabelText = loginView?.signInButton.titleLabel?.text
        XCTAssertNotNil(signInButtonLabelText)
        XCTAssertEqual(signInButtonLabelText, "Sign In")
    }
    
    func testIfActionAssignedToSignInButton() throws {
        guard let signInButtonActions = loginView?.signInButton.actions(forTarget: loginView, forControlEvent: .touchUpInside) else {
            XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
            return
        }
        XCTAssertTrue(signInButtonActions.contains("signInButtonTap"))
    }
    
    func testLoginAPIWithValidCredentials() {
        let validExpectation = expectation(description: "Valid username and password for login")
        LoginService.makeLoginValidatityAPIcall(for: UserCredentials(email: "eve.holt@reqres.in", password: "sds")).done { response in
            XCTAssertTrue(response.isSuccess)
            validExpectation.fulfill()
        }.catch{ error in
            print("Error : \(error)")
            
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testLoginAPIWithInvalidCredentials() {
        let invalidExpectation = expectation(description: "InValid username and password for login")
        invalidExpectation.isInverted = true
        LoginService.makeLoginValidatityAPIcall(for: UserCredentials(email: "eve.holt@reqres.com", password: "sds")).done { response in
            XCTAssertFalse(response.isSuccess)
            invalidExpectation.fulfill()
        }.catch{ error in
            print("Error : \(error)")
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetProfileDetails() {
        let expectation = expectation(description: "profile information api call")
        LoginService.getProfileDetails().done { response in
            XCTAssertNotNil(response.profileInformation)
            XCTAssertNotNil(response.isSuccess)
            if let success = response.isSuccess {
                XCTAssertTrue(success)
            }
            expectation.fulfill()
        }.catch{ error in
            print("Error : \(error)")
            
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetAllStates() {
        let expectation = expectation(description: "States array information api call")
        LoginService.getAllStates().done { response in
            XCTAssertNotNil(response.statesArray)
            XCTAssertNotNil(response.isSucess)
            if let success = response.isSucess {
                XCTAssertTrue(success)
            }
            expectation.fulfill()
        }.catch{ error in
            print("Error : \(error)")
            
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
