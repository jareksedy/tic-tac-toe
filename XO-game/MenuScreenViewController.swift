//
//  MenuScreenViewController.swift
//  XO-game
//
//  Created by Ярослав on 02.10.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class MenuScreenViewController: UIViewController {
    @IBOutlet weak var twoPlayerButton: UIButton!
    @IBOutlet weak var computerButton: UIButton!
    @IBOutlet weak var fiveByFiveButton: UIButton!
    
    @IBAction func twoPlayerButtonTap(_ sender: Any) {
        Session.shared.mode = .againstHuman
        performSegue(withIdentifier: "toGame", sender: self)
    }
    
    @IBAction func computerButtonTap(_ sender: Any) {
        Session.shared.mode = .againstComputer
        performSegue(withIdentifier: "toGame", sender: self)
    }
    
    @IBAction func fiveByFiveButtonTap(_ sender: Any) {
        Session.shared.mode = .fiveByFive
        performSegue(withIdentifier: "toGame", sender: self)
    }
}

enum gameMode {
    case againstHuman
    case againstComputer
    case fiveByFive
}
