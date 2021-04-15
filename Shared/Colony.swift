import Foundation

struct Colony: CustomStringConvertible, Identifiable
{
  var id = UUID()
    
  var size: Int
  var cellSet: Set<Coordinate>

  private (set) var generationNumber = 0

  init(size: Int = 10) {
        self.size = size
    cellSet = Set<Coordinate>()
  }
    
  var cellsArray: [(Int,Int)] {
    var cells = [(Int,Int)]()
    for cell in cellSet {
        cells.append((cell.row,cell.col))
    }
    return cells
  }

  mutating func setColonyFromCoors(cells: [Coordinate]) {
    for cell in cells {
      cellSet.insert(cell)
    }
  }

  mutating func clear() {
    cellSet.removeAll()
  }

  mutating func setCellAlive(_ row: Int, _ col: Int) {
    cellSet.insert(Coordinate(row, col))
  }

  mutating func setCellDead(_ row: Int, _ col: Int) {
    cellSet.remove(Coordinate(row, col))
  }

  func isCellAlive(_ row: Int, _ col: Int) -> Bool {
    return cellSet.contains(Coordinate(row, col))
  }

  var numberLivingCells: Int {
    return cellSet.count
  }

  func livingCells() -> [Coordinate] {
    return Array(cellSet)
  }

    func wrappedPosition(_ c: Coordinate) -> Coordinate {
        return Coordinate((c.row+size) % size,(c.col+size) % size)
  }

  func findNeighbors(_ c: Coordinate, wrapping: Bool = false) -> [Coordinate] {
    var result = [Coordinate]()

    for rowOffset in -1...1 {
      for colOffset in -1...1 {
        let corr = Coordinate(c.row + rowOffset,c.col + colOffset)
        if wrapping {
            result.append(wrappedPosition(corr))
        } else {
            result.append(corr)
        }
      }
    }
    result.remove(at: 4)
    return result
  }
    
    func cellWithinRange(_ cell: Coordinate) -> Bool {
        return cell.row >= 0 && cell.col >= 0 && cell.row < size && cell.col < size
    }

  mutating func evolve(wrapping: Bool = false) {
    generationNumber += 1
    var newCellSet = Set<Coordinate>()
    var deadNeighbors = Set<Coordinate>()

    for cell in cellSet {
      var numNeighbors = 0
        var neighbors = findNeighbors(cell,wrapping:wrapping)

      for neighbor in neighbors {
        if isCellAlive(neighbor.row,neighbor.col) {
          numNeighbors += 1
        } else {
          deadNeighbors.insert(neighbor)
        }
      }
      if (numNeighbors == 3 || numNeighbors == 2) && cellWithinRange(cell) {
        newCellSet.insert(cell)
      }
    }

    for cell in deadNeighbors {
      var numNeighbors = 0
      var neighbors = findNeighbors(cell,wrapping:wrapping)

      for neighbor in neighbors {
        if isCellAlive(neighbor.row,neighbor.col) {
          numNeighbors += 1
        }
      }
        if numNeighbors == 3 && cellWithinRange(cell) {
        newCellSet.insert(cell)
      }
    }

    cellSet = newCellSet
  }

  mutating func evolveWrap() {
    evolve(wrapping: true)
  }

  var description: String {
    print("\nGeneration # \(generationNumber)\n")
    var str = [String](repeating: "", count: size)
    for x in 0..<size{
      for y in 0..<size{
        if isCellAlive(x,y) {
          str[x].append("*")
        }
        else{
          str[x].append(" ")
        }
      }
    }
    for h in str{
      print(h)
    }
    return("")
  }
}
