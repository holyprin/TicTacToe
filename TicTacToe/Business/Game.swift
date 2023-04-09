//
//  Game.swift
//  TicTacToe
//
//  Created by Alicia Tams on 4/5/23.
//

import Foundation

/*
 For simplicity the Game and Player objects are included in the app target. Normally these
 should be placed in a separate library that does not link to UIkit
*/

class Game {
    let size: Int
    var grid: [[Player?]]
    let targetCount: Int

    //Used for draw calculation
    private var moveCount = 0
    
    init(size: Int, targetCount: Int) {
        self.size = size
        self.targetCount = targetCount
        self.grid = Array(repeating: Array(repeating: nil, count: size), count: size)
    }

    /*
     Low complexity but comes at the cost of a bit more memory.
     */
    private func checkForWin(row: Int, column: Int, player: Player) -> Set<GridIndex> {
        //Compute lightest to heaviest
        if case let indexes = checkCorners(player: player), indexes.count == 4 {
            return indexes
        }
        if case let indexes = checkTwoByTwo(row: row, column: column, player: player), indexes.count >= 4 {
            return indexes
        }
        if case let indexes = checkDirections(row: row, column: column, player: player), indexes.count >= targetCount {
            return indexes
        }
        return []
    }
    
    func checkDirections(row: Int, column: Int, player: Player) -> Set<GridIndex> {
        let directions = [(1, 0), (0, 1), (1, 1), (1, -1)] // (Down, Right, Down&Right, Down&Left)
        for (dr, dc) in directions {
            var consecutiveTiles: Set<GridIndex> = [GridIndex(row: row, column: column)]

            // Check in positive direction (Right/Down)
            for i in 1..<targetCount {
                //Calculate new locations based on the direction and targetCount
                let newRow = row + dr * i
                let newCol = column + dc * i

                if isInGrid(row: newRow, column: newCol), grid[newRow][newCol] == player {
                    consecutiveTiles.insert(GridIndex(row: newRow, column: newCol))
                } else {
                    break
                }
            }

            // Check in negative direction (Up/Left)
            for i in 1..<targetCount {
                let newRow = row - dr * i
                let newCol = column - dc * i

                if isInGrid(row: newRow, column: newCol), grid[newRow][newCol] == player {
                    consecutiveTiles.insert(GridIndex(row: newRow, column: newCol))
                } else {
                    break
                }
            }

            if consecutiveTiles.count >= targetCount {
                return consecutiveTiles
            }
        }
        return []
    }
    
    func checkTwoByTwo(row: Int, column: Int, player: Player) -> Set<GridIndex> {
        var completedBlocks: Set<GridIndex> = []
        //offsets to check around the selected tile, as well as the selectedß
        let offsets = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1), (0, 0), (0, 1),
            (1, -1), (1, 0), (1, 1)
        ]
        for offset in offsets {
            let offsetRow = row + offset.0
            let offsetCol = column + offset.1
            
            //Check that the calculated offsets are inside the grid.
            if isInGrid(row: offsetRow, column: offsetCol), isInGrid(row: offsetRow + 1, column: offsetCol + 1),
               grid[offsetRow][offsetCol] == player, //Check previously stored indexes for the current player
               grid[offsetRow][offsetCol + 1] == player,
               grid[offsetRow + 1][offsetCol] == player,
               grid[offsetRow + 1][offsetCol + 1] == player {
                let blockIndices: Set<GridIndex> = [
                    GridIndex(row: offsetRow, column: offsetCol),
                    GridIndex(row: offsetRow, column: offsetCol + 1),
                    GridIndex(row: offsetRow + 1, column: offsetCol),
                    GridIndex(row: offsetRow + 1, column: offsetCol + 1)
                ]
                completedBlocks.formUnion(blockIndices)
            }
        }
        return completedBlocks
    }
    
    func checkCorners(player: Player) -> Set<GridIndex> {
        if grid[0][0] == player, //Top Left
           grid[0][size-1] == player, //Top Right
           grid[size-1][0] == player, //Bottom Left
           grid[size-1][size-1] == player { //Bottom Right

            return Set([
                GridIndex(row: 0, column: 0),
                GridIndex(row: 0, column: size-1),
                GridIndex(row: size-1, column: 0),
                GridIndex(row: size-1, column: size-1)
            ])
        }
        return []
    }

    func placeTile(row: Int, column: Int, player: Player) -> GameResult {
        guard grid[row][column] == nil else { return .illegal }
        
        grid[row][column] = player
        moveCount += 1
        
        // Check win condition based on the last move
        let winningTiles = checkForWin(row: row, column: column, player: player)
        if !winningTiles.isEmpty {
            return .win(player, winningTiles)
        }
        
        // Check for draw condition
        if moveCount == size * size {
            return .draw
        }
        
        return .ongoing
    }
    
    func reset() {
        self.moveCount = 0
        self.grid = Array(repeating: Array(repeating: nil, count: size), count: size)
    }
    
    private func isInGrid(row: Int, column: Int) -> Bool {
        return 0...size-1 ~= row && 0...size-1 ~= column
    }
}

struct GridIndex: Equatable, Hashable {
    var row: Int
    var column: Int
}

enum GameResult: Equatable {
    case ongoing
    case illegal
    case win(Player, Set<GridIndex>)
    case draw
}
