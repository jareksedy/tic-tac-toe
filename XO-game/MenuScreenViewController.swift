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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toGame" else { return }
    }
    
    @IBAction func twoPlayerButtonTap(_ sender: Any) {
        Session.shared.mode = .againstHuman
        performSegue(withIdentifier: "toGame", sender: self)
    }
    
    @IBAction func computerButtonTap(_ sender: Any) {
        Session.shared.mode = .againstComputer
        performSegue(withIdentifier: "toGame", sender: self)
    }
}

enum gameMode {
    case againstHuman
    case againstComputer
}
