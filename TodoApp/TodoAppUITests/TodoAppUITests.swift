//
//  TodoAppUITests.swift
//  TodoAppUITests
//
//  Created by hungdat1234 on 3/19/22.
//

import XCTest
import Nimble

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
        openListScreen_WhenOpen_CallDataAndShowListOnTable(waitFor: 1)
    }
}

// MARK: - SUPPORT FUNCTIONS
extension TodoAppUITests {
    
    private func checkIsHomeScreen_WhenOpen_ShowThreeButton() {
        
        let callListBtn = app.buttons[callListText]
        expect(callListBtn.exists).to(beTrue(), description: "Button exist")
        let buyListBtn = app.buttons[buyListText]
        expect(buyListBtn.exists).to(beTrue(), description: "Button exist")
        let sellListBtn = app.buttons[sellListText]
        expect(sellListBtn.exists).to(beTrue(), description: "Button exist")
    }
    
    private func openListScreen_WhenOpen_CallDataAndShowListOnTable(waitFor: Int) {
        
        let tableView = app.tables.element(boundBy: 0)
        expect(tableView.exists).to(beTrue(), description: "Tableview exist")
        
        // swiftlint:disable:next empty_count
        expect(tableView.cells.count > 0)
            .toEventually(beTrue(),
                          timeout: .seconds(waitFor),
                          description: "tableView have data after fetch list")
        
    }
    
    private func tapOpenListScreen_WhenTap_NavigationToListScreen(_ titleScreen: String) {
        
        checkIsHomeScreen_WhenOpen_ShowThreeButton()
        
        let callListBtn = app.buttons[titleScreen]
        callListBtn.tap()
        
        let titleScreen = app.staticTexts[titleScreen]
        expect(titleScreen.exists).to(beTrue(), description: "Title Screen exist")
    }
    
    private func openCallScreen_WhenOpen_ShowNavAndBackToHome(titleScreen: String) {
        
        tapOpenListScreen_WhenTap_NavigationToListScreen(titleScreen)
        
        let backBtn = app.buttons["leftButton"]
        expect(backBtn.exists).to(beTrue(), description: "Button exist")
        backBtn.tap()
        
        checkIsHomeScreen_WhenOpen_ShowThreeButton()
    }
}
