//
//  GameViewModel.swift
//  Connect4
//
//  Created by Андрей  on 09.05.2024.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    let lastRow: [Int] = [30, 31, 32, 33, 34, 35]
    let diagonalRows: [[Int]] = [[0, 7, 14, 21, 28, 35], [1, 7, 15, 22, 29], [2, 9, 16, 23], [5, 10, 15, 20, 25, 30], [4, 9, 14, 19, 24], [3, 8, 13, 18], [12, 19, 26, 33], [6, 13, 20, 27, 34], [17, 22, 27, 32], [11, 16, 21, 26, 31]]
    
    @Published var lastSlot: Slot? = nil
    @Published var winner: WinAlert? = nil
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 36)
    @Published var turn: Bool = true
    @Published var isAnimated: Bool = false
    @Published var slots: Array<Slot> = [
                                             Slot(boardIndex: 0, filled: nil, columnIndex: 0),
                                             Slot(boardIndex: 1, filled: nil, columnIndex: 1),
                                             Slot(boardIndex: 2, filled: nil, columnIndex: 2),
                                             Slot(boardIndex: 3, filled: nil, columnIndex: 3),
                                             Slot(boardIndex: 4, filled: nil, columnIndex: 4),
                                             Slot(boardIndex: 5, filled: nil, columnIndex: 5),
                                             Slot(boardIndex: 6, filled: nil, columnIndex: 0),
                                             Slot(boardIndex: 7, filled: nil, columnIndex: 1),
                                             Slot(boardIndex: 8, filled: nil, columnIndex: 2),
                                             Slot(boardIndex: 9, filled: nil, columnIndex: 3),
                                             Slot(boardIndex: 10, filled: nil, columnIndex: 4),
                                             Slot(boardIndex: 11, filled: nil, columnIndex: 5),
                                             Slot(boardIndex: 12, filled: nil, columnIndex: 0),
                                             Slot(boardIndex: 13, filled: nil, columnIndex: 1),
                                             Slot(boardIndex: 14, filled: nil, columnIndex: 2),
                                             Slot(boardIndex: 15, filled: nil, columnIndex: 3),
                                             Slot(boardIndex: 16, filled: nil, columnIndex: 4),
                                             Slot(boardIndex: 17, filled: nil, columnIndex: 5),
                                             Slot(boardIndex: 18, filled: nil, columnIndex: 0),
                                             Slot(boardIndex: 19, filled: nil, columnIndex: 1),
                                             Slot(boardIndex: 20, filled: nil, columnIndex: 2),
                                             Slot(boardIndex: 21, filled: nil, columnIndex: 3),
                                             Slot(boardIndex: 22, filled: nil, columnIndex: 4),
                                             Slot(boardIndex: 23, filled: nil, columnIndex: 5),
                                             Slot(boardIndex: 24, filled: nil, columnIndex: 0),
                                             Slot(boardIndex: 25, filled: nil, columnIndex: 1),
                                             Slot(boardIndex: 26, filled: nil, columnIndex: 2),
                                             Slot(boardIndex: 27, filled: nil, columnIndex: 3),
                                             Slot(boardIndex: 28, filled: nil, columnIndex: 4),
                                             Slot(boardIndex: 29, filled: nil, columnIndex: 5),
                                             Slot(boardIndex: 30, filled: nil, columnIndex: 0),
                                             Slot(boardIndex: 31, filled: nil, columnIndex: 1),
                                             Slot(boardIndex: 32, filled: nil, columnIndex: 2),
                                             Slot(boardIndex: 33, filled: nil, columnIndex: 3),
                                             Slot(boardIndex: 34, filled: nil, columnIndex: 4),
                                             Slot(boardIndex: 35, filled: nil, columnIndex: 5),
                                             
    ]
}
