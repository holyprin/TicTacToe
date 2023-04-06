//
//  Player.swift
//  TicTacToe
//
//  Created by Alicia Tams on 4/5/23.
//

import Foundation

enum Player: String {
    case x = "X"
    case o = "O"
    
    mutating func toggle() {
        switch self {
        case .x:
            self = .o
        case .o:
            self = .x
        }
    }
}
