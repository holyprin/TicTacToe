//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Alicia Tams on 4/6/23.
//

import XCTest

@testable import TicTacToe

final class TicTacToeTests: XCTestCase {

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
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test4x4HorizontalWinningCondition() {
        let game = Game(size: 4, targetCount: 4)
        
        // Test horizontal win
        game.grid = [
            [ nil, .x, .x, .x ],
            [ nil, .o, .o, .o ],
            [ nil, nil, nil, nil ],
            [ nil, nil, nil, nil ]
        ]
        XCTAssertEqual(game.placeTile(row: 0, col: 0, player: .x), .win(.x, Set([GridIndex(row: 0, column: 0), GridIndex(row: 0, column: 1), GridIndex(row: 0, column: 2), GridIndex(row: 0, column: 3)])))
    }
    
    func test8x8HorizontalWinTargetCount4Condition() {
        let game = Game(size: 8, targetCount: 4)
        
        // Test horizontal win
        game.grid = [
            [ nil, .x, .x, .x, nil, nil, nil, nil ],
            [ nil, .o, .o, .o, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
        ]
        XCTAssertEqual(game.placeTile(row: 0, col: 4, player: .x), .win(.x, [GridIndex(row: 0, column: 4), GridIndex(row: 0, column: 1), GridIndex(row: 0, column: 2), GridIndex(row: 0, column: 3)]))
    }

}
