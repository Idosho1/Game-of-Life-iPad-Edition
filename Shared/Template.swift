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
    var colony: Colony
}

let blank = Colony(size: 60)
let basic = Colony(size: 60)
let glider = Colony(size: 60)
let gun = Colony(size: 60)

var templates = [Template(name: "Blank", colony: blank),Template(name: "Basic", colony: basic),Template(name: "Glider", colony: glider),Template(name: "Glider Gun", colony: gun)]

