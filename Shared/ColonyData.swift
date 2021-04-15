//
//  ColonyData.swift
//  Game of Life iPad Edition
//
//  Created by Ido Shoshani on 4/15/21.
//

import Foundation
import SwiftUI
import Combine

class ColonyData: ObservableObject {
    @Published var colonys: [Colony]

    init (colonys: [Colony] = []) {
        self.colonys = colonys
        
        
    }
}
