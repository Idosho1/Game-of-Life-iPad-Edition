//
//  Template.swift
//  Game of Life iPad Edition
//
//  Created by Ido Shoshani on 4/25/21.
//

import Foundation

struct Template: Identifiable {
    
    var id = UUID()
    
    var name: String
    var cells: Set<Coordinate>
}

let blank: Set = Set<Coordinate>()
let basic: Set = [Coordinate(5,5),Coordinate(5,6),Coordinate(5,7),Coordinate(6,6)]
let glider: Set = Set<Coordinate>()
let gun: Set = Set<Coordinate>()

var templates = [Template(name: "Blank", cells: blank),Template(name: "Basic", cells: basic),Template(name: "Glider", cells: glider),Template(name: "Glider Gun", cells: gun)]

