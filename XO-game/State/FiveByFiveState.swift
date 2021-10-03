//
//  FiveByFiveState.swift
//  XO-game
//
//  Created by Ярослав on 03.10.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class FiveByFiveState: GameState {
    public let player: Player
    var isMoveCompleted: Bool = false
    private weak var gameViewController: GameViewController?
    private weak var gameBoard: Gameboard?
    private weak var gameBoardView: GameboardView?
    
    var counter = 0

    public let markViewPrototype: MarkView

    init(player: Player, gameViewController: GameViewController,
         gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.markViewPrototype = markViewPrototype
    }

    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second, .computer:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        }

        gameViewController?.winnerLabel.isHidden = true
    }

    func addMark(at position: GameboardPosition) {
        Log(action: .playerSetMark(player: player, position: position))

        guard let gameBoardView = gameBoardView,
              gameBoardView.canPlaceMarkView(at: position) else {
            return
        }

        gameBoard?.setPlayer(player, at: position)
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
        
        if player == .first {
            Session.shared.playerFirstMoves.append(PlayerMove(player: .first, position: position))
        } else {
            Session.shared.playerSecondMoves.append(PlayerMove(player: .second, position: position))
        }
        
        counter += 1
        if counter >= 5 { isMoveCompleted = true }
    }
}
