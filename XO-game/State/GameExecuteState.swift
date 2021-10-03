//
//  GameExecuteState.swift
//  XO-game
//
//  Created by Ярослав on 03.10.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class GameExecuteState: GameState {
    var isMoveCompleted: Bool = false
    private weak var gameViewController: GameViewController?
    private weak var gameBoard: Gameboard?
    private weak var gameBoardView: GameboardView?
    private var player: Player = .first
    private var timer: Timer?
    var completionHandler: () -> Void
    
    init(gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameboardView, _ completionHandler: @escaping () -> Void) {
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.completionHandler = completionHandler
    }
    
    @objc func performMove() {
        if Session.shared.playerFirstMoves.count > 0 || Session.shared.playerSecondMoves.count > 0 {
            var move: PlayerMove?
            
            if player == .first {
                move = Session.shared.playerFirstMoves.removeFirst()
                gameViewController?.firstPlayerTurnLabel.isHidden = false
                gameViewController?.secondPlayerTurnLabel.isHidden = true
                
            } else {
                move = Session.shared.playerSecondMoves.removeFirst()
                gameViewController?.firstPlayerTurnLabel.isHidden = true
                gameViewController?.secondPlayerTurnLabel.isHidden = false
            }
            
            if let move = move {
                addMark(at: move.position)
                player = player.next
            }
            
        } else {
            timer?.invalidate()
            completionHandler()
        }
    }
    
    func begin() {
        timer = Timer.scheduledTimer(timeInterval: 0.75,
                                     target: self,
                                     selector: #selector(performMove),
                                     userInfo: nil, repeats: true)
    }
    
    func addMark(at position: GameboardPosition) {
        guard let gameBoardView = gameBoardView else { return }
        
        gameBoard?.setPlayer(player, at: position)
        
        if !gameBoardView.canPlaceMarkView(at: position) {
            gameBoardView.removeMarkView(at: position)
        }
        
        gameBoardView.placeMarkView(player.markViewPrototype.copy(), at: position)
    }
}
