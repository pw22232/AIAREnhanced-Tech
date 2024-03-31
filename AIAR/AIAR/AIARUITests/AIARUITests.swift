//
//  AIARUITests.swift
//  AIARUITests
//
//  Created by 陈若鑫 on 31/01/2024.
//

import XCTest

final class AIARUITests: XCTestCase {

    override func setUpWithError() throws {
            continueAfterFailure = false
        }

        override func tearDownWithError() throws {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
        }

        func testLandingPageUI() throws {
            let app = XCUIApplication()
            app.launch()

            // Example: Test the existence of a button with accessibility identifier "Go to New Page"
            XCTAssertTrue(app.buttons["Go to New Page"].exists)

            // Add more UI test steps based on your landing page interactions

            // For example, tapping the button to navigate to the next page
            app.buttons["Go to New Page"].tap()

            // You can add more assertions or interactions with elements on the new page if needed
        }

        func testLaunchPerformance() throws {
            if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
                measure(metrics: [XCTApplicationLaunchMetric()]) {
                    XCUIApplication().launch()
                }
            }
        }
}
