//
//  TodoAppUITests.swift
//  TodoAppUITests
//
//  Created by hungdat1234 on 3/19/22.
//

import XCTest

class TodoAppUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private let callListText = "Call List"
    private let buyListText = "Buy List"
    private let sellListText = "Sell List"
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
}

// MARK: - TEST FUNCTIONS
extension TodoAppUITests {
    
    func testNavigationApp() {
        
        app.launch()
        openCallScreen_WhenOpen_ShowNavAndBackToHome(titleScreen: callListText)
        openCallScreen_WhenOpen_ShowNavAndBackToHome(titleScreen: buyListText)
        openCallScreen_WhenOpen_ShowNavAndBackToHome(titleScreen: sellListText)
    }
    
    func testOpenCallListAndLoadData() {
        
        app.launch()
        tapOpenListScreen_WhenTap_NavigationToListScreen(callListText)
        openListScreen_WhenOpen_CallDataAndShowListOnTable(waitFor: 3)
    }
    
    func testOpenBuyListAndLoadData() {
        
        app.launch()
        tapOpenListScreen_WhenTap_NavigationToListScreen(buyListText)
        openListScreen_WhenOpen_CallDataAndShowListOnTable(waitFor: 3)
    }
    
    func testOpenSellListAndLoadData() {
        
        app.launch()
        tapOpenListScreen_WhenTap_NavigationToListScreen(sellListText)
        openListScreen_WhenOpen_CallDataAndShowListOnTable(waitFor: 0)
    }
}

// MARK: - SUPPORT FUNCTIONS
extension TodoAppUITests {
    
    private func checkIsHomeScreen_WhenOpen_ShowThreeButton() {
        
        let callListBtn = app.buttons[callListText]
        XCTAssertTrue(callListBtn.exists)
        let buyListBtn = app.buttons[buyListText]
        XCTAssertTrue(buyListBtn.exists)
        let sellListBtn = app.buttons[sellListText]
        XCTAssertTrue(sellListBtn.exists)
    }
    
    private func openListScreen_WhenOpen_CallDataAndShowListOnTable(waitFor: Int) {
        
        let tableView = app.tables.element(boundBy: 0)
        XCTAssertTrue(tableView.exists)
        
        let exp = expectation(description: "tableView load data after fetch list")
        exp.fulfill()
        
        if waitFor > 0 { sleep(UInt32(waitFor)) }
        waitForExpectations(timeout: TimeInterval(waitFor), handler: nil)
        
        // swiftlint:disable:next empty_count
        XCTAssertTrue(tableView.cells.count > 0)
    }
    
    private func tapOpenListScreen_WhenTap_NavigationToListScreen(_ titleScreen: String) {
        
        checkIsHomeScreen_WhenOpen_ShowThreeButton()
        
        let callListBtn = app.buttons[titleScreen]
        callListBtn.tap()
        
        XCTAssertTrue(app.staticTexts[titleScreen].exists)
    }
    
    private func openCallScreen_WhenOpen_ShowNavAndBackToHome(titleScreen: String) {
        
        tapOpenListScreen_WhenTap_NavigationToListScreen(titleScreen)
        
        let backBtn = app.buttons["leftButton"]
        XCTAssertTrue(backBtn.exists)
        backBtn.tap()
        
        checkIsHomeScreen_WhenOpen_ShowThreeButton()
    }
}
