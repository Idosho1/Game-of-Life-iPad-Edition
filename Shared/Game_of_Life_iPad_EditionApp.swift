//
//  Game_of_Life_iPad_EditionApp.swift
//  Shared
//
//  Created by Ido Shoshani on 3/31/21.
//

import SwiftUI

@main
struct Game_of_Life_iPad_EditionApp: App {
    @StateObject private var colonyData = ColonyData(colonys: [Colony(size: 60)])
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(colonyData)
        }
    }
}
