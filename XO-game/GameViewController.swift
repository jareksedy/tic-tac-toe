//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private let gameBoard = Gameboard()
    private var counter = 0
    private lazy var referee = Referee(gameboard: gameBoard)
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            
            self.currentState.addMark(at: position)
            if self.currentState.isMoveCompleted {
                self.counter += 1
                self.setNextState()
            }
        }
    }
    
    private func setFirstState() {
        let player = Player.first
        
        if Session.shared.mode == .againstComputer {
            currentState = PlayAgainstComputerState(player: player,
                                                    gameViewController: self,
                                                    gameBoard: gameBoard,
                                                    gameBoardView: gameboardView,
                                                    markViewPrototype: player.markViewPrototype)
        } else {
            currentState = PlayerState(player: player,
                                       gameViewController: self,
                                       gameBoard: gameBoard,
                                       gameBoardView: gameboardView,
                                       markViewPrototype: player.markViewPrototype)
        }
    }
    
    private func setNextState() {
        if let winner = referee.determineWinner() {
            Log(action: .gameFinished(winner: winner))
            currentState = GameOverState(winner: winner, gameViewController: self)
            
            return
        }
        
        if counter >= 9 {
            Log(action: .gameFinished(winner: nil))
            currentState = GameOverState(winner: nil, gameViewController: self)
            return
        }
        
        if Session.shared.mode == .againstComputer {
            if let playerInputState = currentState as? PlayAgainstComputerState {
                let player = playerInputState.player.next
                currentState = PlayAgainstComputerState(player: player,
                                                        gameViewController: self,
                                                        gameBoard: gameBoard,
                                                        gameBoardView: gameboardView,
                                                        markViewPrototype: player.markViewPrototype)
            }
        } else {
            if let playerInputState = currentState as? PlayerState {
                let player = playerInputState.player.next
                currentState = PlayerState(player: player,
                                           gameViewController: self,
                                           gameBoard: gameBoard,
                                           gameBoardView: gameboardView,
                                           markViewPrototype: player.markViewPrototype)
            }
        }
    }
    
    private func configureUI() {
        if Session.shared.mode == .againstComputer {
            secondPlayerTurnLabel.text = "Computer"
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(action: .restartGame)
        
        gameboardView.clear()
        gameBoard.clear()
        setFirstState()
        counter = 0
    }
}

