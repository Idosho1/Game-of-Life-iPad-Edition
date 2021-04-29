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
let gun: Set = [Coordinate(20,11),Coordinate(21,11),Coordinate(19,12),Coordinate(18,13),Coordinate(18,14),Coordinate(18,15),Coordinate(19,16),Coordinate(20,17),Coordinate(21,17),Coordinate(22,14),Coordinate(23,12),Coordinate(23,16),Coordinate(24,13),Coordinate(24,14),Coordinate(24,15),Coordinate(25,14),Coordinate(28,11),Coordinate(29,11),Coordinate(28,12),Coordinate(29,12),Coordinate(28,13),Coordinate(29,13),Coordinate(30,10),Coordinate(30,14),Coordinate(32,9),Coordinate(32,10),Coordinate(32,14),Coordinate(32,15),Coordinate(9,13),Coordinate(8,13),Coordinate(9,14),Coordinate(8,14),Coordinate(42,11),Coordinate(43,11),Coordinate(42,13),Coordinate(43,12)]
let glider: Set = [Coordinate(20,20),Coordinate(21,21),Coordinate(22,21),Coordinate(22,20),Coordinate(22,19)]


var templates = [Template(name: "Blank", cells: blank),Template(name: "Basic", cells: basic),Template(name: "Glider", cells: glider),Template(name: "Glider Gun", cells: gun)]

