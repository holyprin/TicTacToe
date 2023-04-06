//
//  MainViewController.swift
//  TicTacToe
//
//  Created by Alicia Tams on 4/5/23.
//

import UIKit

class MainViewController: UIViewController, TicTacToeDelegate {

    // Instructions said not to worry about updating the UI based on the grid size, but I found it helpful for edge case testing.
    let gridSize = 4
    let targetCount = 4 //Should not exceed gridSize or only 2x2 and corners will be found.

    private var currentPlayerIcon: TileControl!
    private var currentPlayerLabel: UILabel!
    private var ticTacToeView: TicTacToeControl!
    private var newGameButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
   
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }
   
    private func createUI() {
       
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
       
        //Title container for safe area padding purposes.
        let titleContainer = UIView()
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        titleContainer.backgroundColor = UIColor(red: 0/255, green: 140/255, blue: 193/255, alpha: 1.0)
        titleContainer.layer.shadowRadius = 10
        titleContainer.layer.shadowOpacity = 0.8
        titleContainer.layer.shadowColor = UIColor.darkGray.cgColor
        titleContainer.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.addSubview(titleContainer)
       
        NSLayoutConstraint.activate([
            titleContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            titleContainer.heightAnchor.constraint(equalToConstant: 100),
            titleContainer.topAnchor.constraint(equalTo: view.topAnchor)
        ])
       
        //Title Label inside the Title container
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Tic Tac Toe"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .natural
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
       
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20)
        ])
       
        //Current Player Label
        currentPlayerLabel = UILabel()
        currentPlayerLabel.translatesAutoresizingMaskIntoConstraints = false
        currentPlayerLabel.text = "Current Player:"
        currentPlayerLabel.font = .systemFont(ofSize: 30, weight: .medium)
        currentPlayerLabel.textColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
       
        NSLayoutConstraint.activate([
            currentPlayerLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
       
        //Current Player Icon
       currentPlayerIcon = TileControl(row: 0, column: 0) //Reusing TileControl because we already have the drawing code in it.
        currentPlayerIcon.tintColor = .darkGray
       
        NSLayoutConstraint.activate([
            currentPlayerIcon.widthAnchor.constraint(equalToConstant: 80),
            currentPlayerIcon.heightAnchor.constraint(equalToConstant: 80)
        ])
       
        //StackView that contains the Current Player Label and Icon
        let stackView = UIStackView(arrangedSubviews: [currentPlayerLabel, currentPlayerIcon])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        view.addSubview(stackView)
       
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: 55)
        ])
       
        //Game Board
        ticTacToeView = TicTacToeControl(gridSize: gridSize, targetCount: targetCount)
        ticTacToeView.backgroundColor = .white
        ticTacToeView.delegate = self
        ticTacToeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ticTacToeView)

        NSLayoutConstraint.activate([
            ticTacToeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ticTacToeView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            ticTacToeView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            ticTacToeView.heightAnchor.constraint(equalTo: ticTacToeView.widthAnchor)
        ])
       
        // New Game Button
        newGameButton = {
            let button = UIButton(type: .system, primaryAction: UIAction(title: "NEW GAME", handler: { [weak self] _ in
                self?.resetGame()
            }))
           
            button.backgroundColor = UIColor(red: 0/255, green: 190/255, blue: 172/255, alpha: 1.0)
            button.titleLabel!.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 3
            button.layer.masksToBounds = true
           
            button.setTitleColor(.white, for: [.normal])
           
            return button
        }()
        view.addSubview(newGameButton)

        NSLayoutConstraint.activate([
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGameButton.topAnchor.constraint(equalTo: ticTacToeView.bottomAnchor, constant: 45),
            newGameButton.heightAnchor.constraint(equalToConstant: 55.0),
            newGameButton.widthAnchor.constraint(equalToConstant: 175.0)
        ])
       
        resetGame()
    }
   
    @objc private func resetGame() {
        ticTacToeView.reset()
        currentPlayerIcon.isHidden = false
        currentPlayerLabel.text = "Current Player:"
        currentPlayerIcon.player = .x
        ticTacToeView.isUserInteractionEnabled = true
    }
   
    // MARK: - TicTacToeDelegate

    func playerDidWin(_ player: Player, winningIndexes: Set<GridIndex>) {
        currentPlayerIcon.isHidden = true
        currentPlayerLabel.text = "\(player.rawValue) Wins!"
        ticTacToeView.isUserInteractionEnabled = false
    }

    func gameEndedInDraw() {
        currentPlayerIcon.isHidden = true
        currentPlayerLabel.text = "Draw!"
        ticTacToeView.isUserInteractionEnabled = false
    }
   
    func playerChanged(_ player: Player) {
        currentPlayerIcon.player = player
    }
}
