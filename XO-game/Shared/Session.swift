//
//  Session.swift
//  XO-game
//
//  Created by Ярослав on 02.10.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class Session {
    
    static let shared = Session()
    private init() {}
    
    var mode: gameMode?
}
