//
//  TicTacToeControl.swift
//  TicTacToe
//
//  Created by Alicia Tams on 4/6/23.
//

import UIKit

protocol TicTacToeDelegate: AnyObject {
    func playerDidWin(_ player: Player, winningIndexes: Set<GridIndex>)
    func playerChanged(_ player: Player)
    func gameEndedInDraw()
}

class TicTacToeControl: UIControl {
    
    weak var delegate: TicTacToeDelegate?
    
    private var game: Game
    private var tiles: [TileControl]!
    private var currentPlayer: Player = .x
    private let stackView: UIStackView
    
    init(gridSize: Int, targetCount: Int) {
        
        self.game = Game(size: gridSize, targetCount: targetCount)
        self.stackView = UIStackView()
        self.tiles = []
        
        super.init(frame: CGRect.zero)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = -1
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        for row in 0..<game.size {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = -1
            stackView.addArrangedSubview(rowStackView)
            
            for col in 0..<game.size {
                let tile = TileControl(row: row, column: col)
                tile.player = nil
                tile.layer.borderWidth = 1
                tile.layer.borderColor = UIColor.lightGray.cgColor
                tile.tintColor = .darkGray
                tile.tapCallback = { [weak self] tile in
                    self?.tappedTile(tile: tile)
                }
                rowStackView.addArrangedSubview(tile)
                tiles.append(tile)
            }
        }
        
        reset()
    }
    
    private func highlightWinningTiles(indexes: Set<GridIndex>) {
        for tile in tiles {
            for idx in indexes {
                if tile.index.row == idx.row && tile.index.column == idx.column {
                    tile.highlight()
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tappedTile(tile: TileControl) {
        let result = game.placeTile(row: tile.index.row, column: tile.index.column, player: currentPlayer)
        
        switch result {
        case .ongoing:
            tile.player = currentPlayer
            currentPlayer.toggle()
            delegate?.playerChanged(currentPlayer)
            print("Continuing...")
        case let .win(player, winningIndexes):
            tile.player = currentPlayer
            delegate?.playerDidWin(player, winningIndexes: winningIndexes)
            highlightWinningTiles(indexes: winningIndexes)
            print("\(player.rawValue) wins! Winning tiles: \(winningIndexes)")
        case .draw:
            tile.player = currentPlayer
            delegate?.gameEndedInDraw()
            print("It's a draw!")
        case .illegal:
            break
        }
    }
    
    func reset() {
        game.reset()
        currentPlayer = .x
        for tile in tiles {
            tile.player = nil
            tile.clearHighlight()
        }
    }
}
