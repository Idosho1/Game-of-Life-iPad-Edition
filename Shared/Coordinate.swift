//
//  Coordinate.swift
//  Game of Life iPad Edition
//
//  Created by Ido Shoshani on 4/3/21.
//

import Foundation

struct Coordinate: CustomStringConvertible, Hashable, Identifiable {
    var id : Int {
        return (col * 60) + row
    }
    
  let row: Int
  let col: Int
    
    init(_ row: Int, _ col: Int) {
        self.row = row
        self.col = col
    }
  
  static func makeCoors(data: [(row: Int, col: Int)]) -> [Coordinate] {
    var coordinates = [Coordinate]()

    for coordinate in data {
      coordinates.append(Coordinate(coordinate.row, coordinate.col))
    }

    return coordinates
  }

  var description: String {
    return "(\(row), \(col))"
  }
}
