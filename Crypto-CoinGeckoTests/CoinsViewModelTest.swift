//
//  CoinsViewModelTest.swift
//  Crypto-CoinGeckoTests
//
//  Created by Gourob Mazumder on 13/7/24.
//

import XCTest
@testable import Crypto_CoinGecko


class CoinsViewModelTest: XCTestCase {
    
    var viewModel: CoinsViewModel!
    var mockCoinService: MockCoinService!
    
    override func setUp() {
        super.setUp()
        mockCoinService = MockCoinService()
        viewModel = CoinsViewModel(coinService: mockCoinService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockCoinService = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(viewModel)
    }

    func testGetCoinsSuccess() async {
        // Given
        mockCoinService.shouldReturnError = false
        
        // When
        await viewModel.getCoins()
        
        // Then
        XCTAssertFalse(viewModel.coins.isEmpty, "Coins should not be empty")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil")
    }
    
    func testGetCoins_Failure() async {
        // Given
        mockCoinService.shouldReturnError = true
        
        // When
        await viewModel.getCoins()
        
        // Then
        XCTAssertTrue(viewModel.coins.isEmpty, "Coins should be empty")
        XCTAssertNotNil(viewModel.errorMessage, "Error message should not be nil")
    }
}
