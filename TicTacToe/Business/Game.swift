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

    init(size: Int, targetCount: Int) {
        self.size = size
        self.targetCount = targetCount
        self.grid = Array(repeating: Array(repeating: nil, count: size), count: size)
    }

    /*
     Low complexity but comes at the cost of memory, This will also identify win conditions
     that exceed the targetCount when long rows are joined by a connecting tile.
     */
    private func checkForWin(row: Int, col: Int, player: Player) -> Set<GridIndex> {
        /*
         This for loop and the contained could be simplified but it introduces more complexity and possible bugs than necessary.
         While it's not DRY by any means, it's far easier to read than a negative to positive for loop for the same complexity.
        */
        let directions = [(1, 0), (0, 1), (1, 1), (1, -1)]
        for (dr, dc) in directions {
            var consecutiveTiles: Set<GridIndex> = [GridIndex(row: row, column: col)]

            // Check in positive direction (Right/Down)
            for i in 1..<targetCount {
                let newRow = row + dr * i
                let newCol = col + dc * i

                if  newRow >= 0, newRow < size, newCol >= 0, //Verifies the newRow is inside the grid
                    newCol < size, grid[newRow][newCol] == player //Checks to see if the tile was previously stored (tapped)
                {
                    consecutiveTiles.insert(GridIndex(row: newRow, column: newCol))
                } else {
                    break
                }
            }

            // Check in negative direction (Up/Left)
            for i in 1..<targetCount {
                let newRow = row - dr * i
                let newCol = col - dc * i

                if  newRow >= 0, newRow < size, newCol >= 0, newCol < size, //Verifies the newRow is inside the grid
                    grid[newRow][newCol] == player //Checks to see if the tile was previously stored (tapped)
                {
                    consecutiveTiles.insert(GridIndex(row: newRow, column: newCol))
                } else {
                    break
                }
            }

            if consecutiveTiles.count >= targetCount {
                return consecutiveTiles
            }
        }

        // Check 2x2 offsets
        let offsets = [(-1, -1), (-1, 0), (0, -1), (0, 0)] //Adjacent tile directions
        for (offsetRow, offsetCol) in offsets {
            let topLeftRow = row + offsetRow
            let topLeftCol = col + offsetCol

            if topLeftRow >= 0, topLeftRow + 1 < size, topLeftCol >= 0, topLeftCol + 1 < size, // Verify the selected location is in the grid
               grid[topLeftRow][topLeftCol] == player,
               grid[topLeftRow][topLeftCol + 1] == player,
               grid[topLeftRow + 1][topLeftCol] == player,
               grid[topLeftRow + 1][topLeftCol + 1] == player {
                
                return [
                    GridIndex(row: topLeftRow, column: topLeftCol),
                    GridIndex(row: topLeftRow, column: topLeftCol + 1),
                    GridIndex(row: topLeftRow + 1, column: topLeftCol),
                    GridIndex(row: topLeftRow + 1, column: topLeftCol + 1)
                ]
            }
        }
        
        // Check corners, super easy hard coded check
        if grid[0][0] == player, //Top Left
           grid[0][size - 1] == player, //Top Right
           grid[size - 1][0] == player, //Bottom Left
           grid[size - 1][size - 1] == player { //Bottom Right

            return [
                GridIndex(row: 0, column: 0),
                GridIndex(row: 0, column: size - 1),
                GridIndex(row: size - 1, column: 0),
                GridIndex(row: size - 1, column: size - 1)
            ]
        }
        return []
    }
    
    private var numberOfMoves = 0
    func placeTile(row: Int, col: Int, player: Player) -> GameResult {
        guard grid[row][col] == nil else { return .illegal }
        
        grid[row][col] = player
        numberOfMoves += 1
        
        // Check win condition based on the last move
        let winningTiles = checkForWin(row: row, col: col, player: player)
        if !winningTiles.isEmpty {
            return .win(player, winningTiles)
        }
        
        // Check for draw condition
        if numberOfMoves == size * size {
            return .draw
        }
        
        return .ongoing
    }
    
    func reset() {
        self.numberOfMoves = 0
        self.grid = Array(repeating: Array(repeating: nil, count: size), count: size)
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
