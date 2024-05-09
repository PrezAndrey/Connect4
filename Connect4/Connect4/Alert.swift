//
//  Alert.swift
//  Connect4
//
//  Created by Андрей  on 02.05.2024.
//

import SwiftUI

struct WinAlert: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertCase {
    static let YellowWins = WinAlert(title: Text("Yellow wins!!!"), message: Text("Yellow is smarter this time"), buttonTitle: Text("Go on!"))
    static let RedWins = WinAlert(title: Text("Red wins!!!"), message: Text("Red is smarter this time"), buttonTitle: Text("Hell yeah"))
    static let InADraw = WinAlert(title: Text("Thats a draw!!!"), message: Text("It seems both of you are not smart enough to win"), buttonTitle: Text("Rematch"))
}
