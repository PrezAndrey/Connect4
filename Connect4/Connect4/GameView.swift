//
//  ContentView.swift
//  Connect4
//
//  Created by Андрей  on 06.03.2024.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        
        VStack {
            Circle()
                .frame(width: viewModel.isAnimated ? 1500 : 150)
                .padding(.vertical, 50)
                .foregroundColor(determineColor())
            
                .overlay {
                    Text("Turn")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
         
                .animation(Animation.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 1.0))
            LazyVGrid(columns: viewModel.columns, spacing: 10) {
                ForEach(0..<36) { i in
                    Circle()
                        .frame(width: 50)
                        .foregroundColor(viewModel.slots[i].filled?.indicator)
                        .onTapGesture {
                            let tappedCol = viewModel.slots[i].columnIndex
                            SoundManager.instance.playSound()
                            for slot in viewModel.slots {
                                
                                if slot.columnIndex == tappedCol {
                                    if slot.filled == nil && !viewModel.lastRow.contains(slot.boardIndex) {
                                        viewModel.lastSlot = slot
                                    }
                                    else {
                                        if viewModel.lastRow.contains(slot.boardIndex) && slot.filled == nil {
                                            viewModel.lastSlot = slot
                                            viewModel.lastSlot?.filled = Move(player: determineTurn(), boardIndex: i)
                                            if let newSlot = viewModel.lastSlot {
                                                viewModel.slots[newSlot.boardIndex] = newSlot
                                            }
                                            break
                                        }
                                        else {
                                            viewModel.lastSlot?.filled = Move(player: determineTurn(), boardIndex: i)
                                            if let newSlot = viewModel.lastSlot {
                                                viewModel.slots[newSlot.boardIndex] = newSlot
                                            }
                                        }
                                    }
                                }
                            }
                            
                            if checkWinCmbination(player: .red) && viewModel.winner == nil {
                                viewModel.winner = AlertCase.RedWins
                                viewModel.isAnimated = true
                            }
                            if checkWinCmbination(player: .yellow) && viewModel.winner == nil {
                                viewModel.winner = AlertCase.YellowWins
                                viewModel.isAnimated = true
                            }
                            
                            
                            viewModel.lastSlot = nil
                            viewModel.turn.toggle()
                        }
                }
            }
        }
        .alert(item: $viewModel.winner) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {
                resetAll()
            }))
        }
    }
    
    func resetAll() {
        viewModel.winner = nil
        viewModel.slots = [
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
    
    func determineTurn() -> Player {
        if viewModel.turn {
            return Player.red
        } else {
            return Player.yellow
        }
    }
    
    func determineColor() -> Color {
        if viewModel.turn {
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
            for slot in viewModel.slots {
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
        for slot in viewModel.slots {
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
        for slot in viewModel.slots {
            if slot.boardIndex == boardIndex {
                return slot
            }
        }
        return nil
    }
    
    func checkDiagonalWinCombination(for player: Player) -> Bool {
        var filledSlots = 0
        for slotArray in viewModel.diagonalRows {
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
        GameView()
    }
}
