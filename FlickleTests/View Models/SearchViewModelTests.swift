//
//  SearchViewModelTests.swift
//  Flickle
//
//  Created by Nate Armstrong on 12/10/15.
//  Copyright © 2015 Nate Armstrong. All rights reserved.
//

import XCTest
@testable import Flickle

class SearchViewModelTests: XCTestCase {

    lazy var viewModel: SearchViewModel = {
        let networkController = NetworkController(baseURL: "https://api.flickr.com/services/rest/")
        let api = FlickrApi(networkController: networkController, apiKey: "1dd17dde0fed7286935d83875fcc17dd")
        return SearchViewModel(api: api)
    }()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSearch() {
        // Given
        let expectation = expectationWithDescription("search for puppies")
        var response: [Photo]?
        viewModel.query.value = "puppies"

        // When
        viewModel.search()
            .onSuccess { (photos: [Photo]) in
                response = photos
                expectation.fulfill()
            }
            .onFailure { error in
                XCTFail()
            }

        waitForExpectationsWithTimeout(6, handler: nil)

        // Then
        guard response != nil else {
            XCTFail("response should not be nil")
            return
        }

        XCTAssert(response!.count > 0, "should have at least 1 puppy photo")
    }
    
}
