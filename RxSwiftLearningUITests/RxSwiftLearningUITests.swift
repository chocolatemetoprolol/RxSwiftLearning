//
//  RxSwiftLearningUITests.swift
//  RxSwiftLearningUITests
//
//  Created by lovechocolate on 2021/3/31.
//  Copyright © 2021 WR. All rights reserved.
//

import XCTest

class RxSwiftLearningUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let username =  app.otherElements["Email"]
        username.tap()
        username.typeText("123456@qq.com")
        let password = app.otherElements["Password"]
        password.tap()
        password.typeText("123123123")
        app.buttons["SIGN IN"].tap()
        sleep(5)
        let table = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element
        let tables = app.tables
        table.swipeDown()
        table.swipeUp()
        let searchTextBar =
            app.otherElements["searchTextBar"].children(matching: .other).element.children(matching: .searchField).element
        searchTextBar.tap()
        searchTextBar.typeText("2021")
        gotoNext(tables, app)
        app.navigationBars["TableViewList"].buttons["Back"].tap()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func gotoNext(_ tables:XCUIElementQuery,_ app:XCUIApplication) -> Void {
        let cells = tables.cells
        if cells.count > 0 {
            let cell =  cells.element(boundBy: 0)
            cell.tap()
            sleep(3)
            app.navigationBars["CollectViewList"].buttons["Back"].tap()
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
