//
//  ContentView.swift
//  Connect4
//
//  Created by Андрей  on 06.03.2024.
//

import SwiftUI

struct ContentView: View {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    private let diagonalRows: [[Int]] = [[0, 7, 14, 21, 28, 35], [1, 7, 15, 22, 29], [2, 9, 16, 23], [5, 10, 15, 20, 25, 30], [4, 9, 14, 19, 24], [3, 8, 13, 18], [12, 19, 26, 33], [6, 13, 20, 27, 34], [17, 22, 27, 32], [11, 16, 21, 26, 31]]
    @State private var lastSlot: Slot? = nil
    private let lastRow: [Int] = [30, 31, 32, 33, 34, 35]
    @State private var moves: [Move?] = Array(repeating: nil, count: 36)
    @State private var turn: Bool = true
    @State private var slots: Array<Slot> = [
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
    
    var body: some View {
        
        VStack {
            Circle()
                .frame(width: 150)
                .padding(.vertical, 50)
                .foregroundColor(determineColor())
                .overlay {
                    Text("Turn")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<36) { i in
                    Circle()
                        .frame(width: 50)
                        .foregroundColor(slots[i].filled?.indicator)
                        .overlay(content: {
                            Text("\(i)")
                                .foregroundColor(.white)
                        })
                        .onTapGesture {
                            let tappedCol = slots[i].columnIndex
                            SoundManager.instance.playSound()
                            for slot in slots {
                                
                                if slot.columnIndex == tappedCol {
                                    if slot.filled == nil && !lastRow.contains(slot.boardIndex) {
                                        lastSlot = slot
                                    }
                                    else {
                                        if lastRow.contains(slot.boardIndex) && slot.filled == nil {
                                            lastSlot = slot
                                            lastSlot?.filled = Move(player: determineTurn(), boardIndex: i)
                                            if let newSlot = lastSlot {
                                                slots[newSlot.boardIndex] = newSlot
                                            }
                                            break
                                        }
                                        else {
                                            lastSlot?.filled = Move(player: determineTurn(), boardIndex: i)
                                            if let newSlot = lastSlot {
                                                slots[newSlot.boardIndex] = newSlot
                                            }
                                        }
                                    }
                                }
                            }
                            
                            if checkWinCmbination(player: .red) {
                                print("________RED WINS________")
                            }
                            if checkWinCmbination(player: .yellow) {
                                print("________YELLOW WINS________")
                            }
                            
                            
                            lastSlot = nil
                            turn.toggle()
                        }
                }
            }
        }
    }
    
    func determineTurn() -> Player {
        if turn {
            return Player.red
        } else {
            return Player.yellow
        }
    }
    
    func determineColor() -> Color {
        if turn {
            return Color.red
        }
        return Color.yellow
    }
    
    func createSlots() -> Array<Slot> {
        var s: [Slot] = []
        for col in 0..<6 {
            for slot in stride(from: col, to: col+30, by: 6) {
                s.append(Slot(boardIndex: slot, columnIndex: col))
            }
        }
        print(s)
        return s
    }
    
    func checkWinCmbination(player: Player) -> Bool {
        if checkRowWinCombinations(for: player) {
            return true
        }
        if checkColWinCombinations(for: player) {
            return true
        }
        if checkDiagonalWinCombination(for: player) {
            return true
        }
        return false
    }
    
    func checkColWinCombinations(for player: Player) -> Bool {
        var filledRows = 0
        let reloadSlots = [0, 1, 2, 3, 4, 5]
        for col in 0..<6 {
            for slot in slots {
                if slot.columnIndex != col {
                    continue
                }
                if reloadSlots.contains(slot.boardIndex) {
                    filledRows = 0
                }
                if slot.filled != nil && slot.filled?.player == player {
                    filledRows += 1
                    if filledRows == 4 {
                        return true
                    }
                }
                else {
                    filledRows = 0
                }
                
            }
        }
        return false

    }
    
    func checkRowWinCombinations(for player: Player) -> Bool {
        var filledRows = 0
        let reloadSlots = [0, 6, 12, 18, 24, 30]
        for slot in slots {
            if reloadSlots.contains(slot.boardIndex) {
                filledRows = 0
            }
            if slot.filled != nil && slot.filled?.player == player {
                filledRows += 1
                if filledRows == 4 {
                    return true
                }
            }
            else {
                filledRows = 0
            }
        }
        return false
    }
    
    func getSlot(boardIndex: Int) -> Slot? {
        for slot in slots {
            if slot.boardIndex == boardIndex {
                return slot
            }
        }
        return nil
    }
    
    func checkDiagonalWinCombination(for player: Player) -> Bool {
        var filledSlots = 0
        for slotArray in diagonalRows {
            for index in slotArray {
                let slot = getSlot(boardIndex: index)!
                if slot.filled != nil && slot.filled?.player == player {
                    filledSlots += 1
                    if filledSlots == 4 {
                        return true
                    }
                }
                else {
                    filledSlots = 0
                }
            }
        }
        return false
    }
    
}



enum Player {
    case red
    case yellow
}
struct Slot {
    let boardIndex: Int
    var filled: Move?
    let columnIndex: Int
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: Color {
        return player == .red ? Color.red : Color.yellow
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
