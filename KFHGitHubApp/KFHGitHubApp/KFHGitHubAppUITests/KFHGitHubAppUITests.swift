//
//  KFHGitHubAppUITests.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//

import XCTest

final class KFHGitHubAppUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testBypassLoginAndGoToRepoList() throws {
        
        let app = XCUIApplication()
        app.launchEnvironment["mock_token"] = "true"
        app.launch()

        let repoListScreen = app.otherElements["repoListScreen"]
        XCTAssertTrue(repoListScreen.waitForExistence(timeout: 10))
    }
    
    func testRepoListAppearsIfMockTokenInjected() throws {
        let app = XCUIApplication()
        app.launchEnvironment["mock_token"] = "true"
        app.launch()

        let repoListScreen = app.otherElements["repoListScreen"]
        XCTAssertTrue(repoListScreen.waitForExistence(timeout: 10), "❌ Repo list screen did not appear")
    }
}

