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
    
    var mode: gameMode?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toGame" else { return }
        let destination = segue.destination as! GameViewController
        destination.mode = mode
    }
    
    @IBAction func twoPlayerButtonTap(_ sender: Any) {
        mode = .againstHuman
        performSegue(withIdentifier: "toGame", sender: self)
    }
    
    @IBAction func computerButtonTap(_ sender: Any) {
        mode = .againstComputer
        performSegue(withIdentifier: "toGame", sender: self)
    }
}

enum gameMode {
    case againstHuman
    case againstComputer
}
