//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Alicia Tams on 4/6/23.
//

import XCTest

@testable import TicTacToe

final class TicTacToeTests: XCTestCase {
    
    func test4x4x4HorizontalWinCondition() {
        let game = Game(size: 4, targetCount: 4)
        
        game.grid = [
            [ nil,  .x,  .x,  .x ],
            [ nil,  .o,  .o,  .o ],
            [ nil, nil, nil, nil ],
            [ nil, nil, nil, nil ]
        ]
        XCTAssertEqual(game.placeTile(row: 0, column: 0, player: .x), .win(.x, [GridIndex(row: 0, column: 0),
                                                                             GridIndex(row: 0, column: 1),
                                                                             GridIndex(row: 0, column: 2),
                                                                             GridIndex(row: 0, column: 3)
                                                                            ]))
    }
    
    func test4x4x4VerticalWinCondition() {
        let game = Game(size: 4, targetCount: 4)
        
        game.grid = [
            [ nil, nil,  .o, nil ],
            [ nil, nil,  .o, nil ],
            [ nil, nil,  .o, nil ],
            [ nil, nil, nil, nil ]
        ]
        XCTAssertEqual(game.placeTile(row: 3, column: 2, player: .o), .win(.o, [GridIndex(row: 0, column: 2),
                                                                             GridIndex(row: 1, column: 2),
                                                                             GridIndex(row: 2, column: 2),
                                                                             GridIndex(row: 3, column: 2)
                                                                            ]))
    }
    
    func test4x4x4DiagonalWinCondition() {
        let game = Game(size: 4, targetCount: 4)
        
        game.grid = [
            [  .o, nil, nil,  nil ],
            [ nil,  .o, nil,  nil ],
            [ nil, nil,  .o,  nil ],
            [ nil, nil, nil,  nil ]
        ]
        XCTAssertEqual(game.placeTile(row: 3, column: 3, player: .o), .win(.o, [GridIndex(row: 0, column: 0),
                                                                             GridIndex(row: 1, column: 1),
                                                                             GridIndex(row: 2, column: 2),
                                                                             GridIndex(row: 3, column: 3)
                                                                            ]))
    }
    
    func test4x4x4ReverseDiagonalWinCondition() {
        let game = Game(size: 4, targetCount: 4)
        
        game.grid = [
            [ nil, nil, nil,  .o ],
            [ nil, nil,  .o, nil ],
            [ nil,  .o, nil, nil ],
            [ nil, nil, nil, nil ]
        ]
        XCTAssertEqual(game.placeTile(row: 3, column: 0, player: .o), .win(.o, [GridIndex(row: 0, column: 3),
                                                                             GridIndex(row: 1, column: 2),
                                                                             GridIndex(row: 2, column: 1),
                                                                             GridIndex(row: 3, column: 0)
                                                                            ]))
    }
    
    func test4x4x4CornersWinCondition() {
        let game = Game(size: 4, targetCount: 4)
        
        game.grid = [
            [  .x, nil,  .o,  .x ],
            [ nil, nil,  .o, nil ],
            [ nil, nil,  .o, nil ],
            [ nil, nil, nil,  .x ]
        ]
        XCTAssertEqual(game.placeTile(row: 3, column: 0, player: .x), .win(.x, [GridIndex(row: 0, column: 0),
                                                                             GridIndex(row: 0, column: 3),
                                                                             GridIndex(row: 3, column: 3),
                                                                             GridIndex(row: 3, column: 0)
                                                                            ]))
    }
    
    func test4x4x4BoxWinCondition() {
        let game = Game(size: 4, targetCount: 4)
        
        game.grid = [
            [ nil, nil, nil,  nil ],
            [ nil, nil, nil,  nil ],
            [ nil, nil,  .o,  .o  ],
            [ nil, nil,  .o,  nil ]
        ]
        XCTAssertEqual(game.placeTile(row: 3, column: 3, player: .o), .win(.o, [GridIndex(row: 3, column: 3),
                                                                             GridIndex(row: 3, column: 2),
                                                                             GridIndex(row: 2, column: 3),
                                                                             GridIndex(row: 2, column: 2)
                                                                            ]))
    }
    
    func test8x8x4HorizontalWinCondition() {
        let game = Game(size: 8, targetCount: 4)
        
        game.grid = [
            [ nil, .x, .x, .x, nil, nil, nil, nil ],
            [ nil, .o, .o, .o, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
        ]
        XCTAssertEqual(game.placeTile(row: 0, column: 4, player: .x), .win(.x, [GridIndex(row: 0, column: 4),
                                                                             GridIndex(row: 0, column: 1),
                                                                             GridIndex(row: 0, column: 2),
                                                                             GridIndex(row: 0, column: 3)
                                                                            ]))
    }
    
    func test8x8x8HorizontalWinCondition() {
        let game = Game(size: 8, targetCount: 8)
        
        game.grid = [
            [ nil, nil,  .o,  .o, nil,  .o, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [  .x,  .x,  .x,  .x, nil,  .x,  .x,  .x ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil,  .o, nil, nil,  .o, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil,  .o, nil ],
            [ nil,  .o, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
        ]
        XCTAssertEqual(game.placeTile(row: 2, column: 4, player: .x), .win(.x,
                                                                        [GridIndex(row: 2, column: 0),
                                                                         GridIndex(row: 2, column: 1),
                                                                         GridIndex(row: 2, column: 2),
                                                                         GridIndex(row: 2, column: 3),
                                                                         GridIndex(row: 2, column: 4),
                                                                         GridIndex(row: 2, column: 5),
                                                                         GridIndex(row: 2, column: 6),
                                                                         GridIndex(row: 2, column: 7)
                                                                        ]))
    }
    
    func test8x8x6VerticalWinCondition7ConnectedWins() { //Greater than 6 and connected by a common adjacent tile
        let game = Game(size: 8, targetCount: 6)
        
        game.grid = [
            [ nil,  .o, nil, nil,  .x,  nil, nil, nil ],
            [ nil, nil, nil, nil,  .x,  nil, nil,  .o ],
            [ nil, nil, nil, nil,  .x,  nil, nil, nil ],
            [ nil, nil, nil, nil,  .x,  nil, nil, nil ],
            [ nil,  .o, nil, nil, nil,  nil, nil, nil ],
            [ nil, nil, nil, nil,  .x,  nil, nil, nil ],
            [ nil, nil, nil, nil,  .x,  nil, nil, nil ],
            [ nil, nil, nil, nil, nil,  nil,  .o, nil ]
        ]
        XCTAssertEqual(game.placeTile(row: 4, column: 4, player: .x), .win(.x,
                                                                        [GridIndex(row: 0, column: 4),
                                                                         GridIndex(row: 1, column: 4),
                                                                         GridIndex(row: 2, column: 4),
                                                                         GridIndex(row: 3, column: 4),
                                                                         GridIndex(row: 4, column: 4),
                                                                         GridIndex(row: 5, column: 4),
                                                                         GridIndex(row: 6, column: 4),
                                                                        ]))
    }
    
    func test8x8x6DiagonalWinConndition() {
        let game = Game(size: 8, targetCount: 6)
        
        game.grid = [
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, .o,  nil, nil, nil, nil, nil, nil ],
            [ nil, nil, .o,  nil, nil, nil, nil, nil ],
            [ nil, nil, nil, .o,  nil, nil, nil, nil ],
            [ nil, nil, nil, nil, .o,  nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, .o,  nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ]
        ]
        XCTAssertEqual(game.placeTile(row: 5, column: 5, player: .o), .win(.o,
                                                                        [GridIndex(row: 1, column: 1),
                                                                         GridIndex(row: 2, column: 2),
                                                                         GridIndex(row: 3, column: 3),
                                                                         GridIndex(row: 4, column: 4),
                                                                         GridIndex(row: 5, column: 5),
                                                                         GridIndex(row: 6, column: 6)
                                                                        ]))
    }
    
    func test8x8x6CornerWinCondition() {
        let game = Game(size: 8, targetCount: 6)

        game.grid = [
            [  .o, nil, nil, nil, nil, nil, nil,  .o ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil,  .o ]
        ]
        
        XCTAssertEqual(game.placeTile(row: 7, column: 0, player: .o), .win(.o,
                                                                        [GridIndex(row: 0, column: 0),
                                                                         GridIndex(row: 0, column: 7),
                                                                         GridIndex(row: 7, column: 0),
                                                                         GridIndex(row: 7, column: 7)
                                                                        ]))
    }
    
    //Special condition where the final piece ends up creating 2 separate 2x2's
    func test8x8x6Special2x2WinCondition() {
        let game = Game(size: 8, targetCount: 6)

        game.grid = [
            [  .o, nil, nil, nil, nil, nil, nil,  .o ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil,  .x,  .x, nil, nil, nil ],
            [ nil, nil,  .x, nil,  .x, nil, nil, nil ],
            [ nil, nil,  .x,  .x,  .x, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil,  .o ]
        ]
        
        XCTAssertEqual(game.placeTile(row: 3, column: 3, player: .x), .win(.x,
                                                                           [GridIndex(row: 2, column: 3),
                                                                            GridIndex(row: 2, column: 4),
                                                                            GridIndex(row: 3, column: 2),
                                                                            GridIndex(row: 3, column: 3),
                                                                            GridIndex(row: 3, column: 4),
                                                                            GridIndex(row: 4, column: 2),
                                                                            GridIndex(row: 4, column: 3),
                                                                            GridIndex(row: 4, column: 4),
                                                                           ]))
    }
    
    func test8x8x8BoxWinCondition() {
        let game = Game(size: 8, targetCount: 8)

        game.grid = [
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil,  .o,  .o, nil, nil, nil ],
            [ nil, nil, nil, nil,  .o, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil ]
        ]
        XCTAssertEqual(game.placeTile(row: 5, column: 3, player: .o), .win(.o,
                                                                        [GridIndex(row: 4, column: 3),
                                                                         GridIndex(row: 4, column: 4),
                                                                         GridIndex(row: 5, column: 3),
                                                                         GridIndex(row: 5, column: 4)
                                                                        ]))
    }
    
    func test20x20x15DiagonalWinCondition() {
        let game = Game(size:20,targetCount: 15)
        
        game.grid = [
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, .x,  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, .x,  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, .x,  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, .x,  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, .x,  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, .x,  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, .x,  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, .x,  nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, .x,  nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, .x,  nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, .x,  nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, .x,  nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, .x,  nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, .x,  nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, .x,  nil ]
        ]
        
        XCTAssertEqual(game.placeTile(row: 13, column: 12, player: .x), .win(.x,
                                                                          [GridIndex(row: 4, column: 3),
                                                                           GridIndex(row: 5, column: 4),
                                                                           GridIndex(row: 6, column: 5),
                                                                           GridIndex(row: 7, column: 6),
                                                                           GridIndex(row: 8, column: 7),
                                                                           GridIndex(row: 9, column: 8),
                                                                           GridIndex(row: 10, column: 9),
                                                                           GridIndex(row: 11, column: 10),
                                                                           GridIndex(row: 12, column: 11),
                                                                           GridIndex(row: 13, column: 12),
                                                                           GridIndex(row: 14, column: 13),
                                                                           GridIndex(row: 15, column: 14),
                                                                           GridIndex(row: 16, column: 15),
                                                                           GridIndex(row: 17, column: 16),
                                                                           GridIndex(row: 18, column: 17),
                                                                           GridIndex(row: 19, column: 18)
                                                                          ]))
    }

}
