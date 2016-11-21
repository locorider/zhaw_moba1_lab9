//: Playground - noun: a place where people can play

import UIKit

let ROWS = 10
let COLS = 10

enum CellState: Int {
    case alive = 1, dead = 0, uknown = 3;
}

class Board {
    
    var cellValues: [[CellState]] = []
    
    required init() {
        for _ in 0..<COLS {
            var row: [CellState] = []
            for _ in 0..<ROWS {
                row.append(.dead)
            }
            cellValues.append(row)
        }
    }
    
    func findNeighbours(x: Int, y: Int) -> [CellState] {
        let ux = y - 1, lx = y + 1
        var neighbours: [CellState] = []
        if ux >= 0 {
            let y0 = x - 1, y1 = x + 1
            if y0 >= 0 {
                neighbours.append(cellValues[ux][y0])
            }
            neighbours.append(cellValues[ux][y])
            
            if y1 < ROWS {
                neighbours.append(cellValues[ux][y1])
            }
        }
        
        let y0 = x - 1, y1 = x + 1
        
        if y0 >= 0 {
            neighbours.append(cellValues[x][y0])
        }
        
        if y1 < ROWS {
            neighbours.append(cellValues[x][y1])
        }
        
        if lx < COLS {
            let y0 = x - 1, y1 = x + 1
            if y0 >= 0 {
                neighbours.append(cellValues[lx][y0])
            }
            neighbours.append(cellValues[lx][y])
            
            if y1 < ROWS {
                neighbours.append(cellValues[lx][y1])
            }
        }
        
        return neighbours
    }
    
    func cellDies(x: Int, y: Int) -> Bool {
        let neighbours = findNeighbours(x: x, y: y)
        let aliveCells = neighbours.filter { $0 == .alive }
        let deadCells = neighbours.filter { $0 == .dead }
        let dies = aliveCells.count > 3 || deadCells.count < 2
        
        //print("cellDies: \(dies) \(aliveCells.count) \(deadCells.count)")
        
        return dies
    }
    
    func cellBecomesAlive(x: Int, y: Int) -> Bool {
        let neighbours = findNeighbours(x: x, y: y)
        let aliveCells = neighbours.filter { $0 == .alive }
        
        return aliveCells.count == 3
    }
    
    func iterate() {
        for x in 0..<COLS {
            for y in 0..<ROWS {
                let cell = cellValues[x][y]
                if .alive == cell && cellDies(x: x, y: y) {
                    cellValues[x][y] = .dead
                } else if .dead == cell && cellBecomesAlive(x: x, y: y) {
                    cellValues[x][y] = .alive
                }
                
                //print("\(x) \(y) prev: \(cell), after: \(cellValues[x][y])")
            }
        }
    }
}

func random() -> CellState {
    return CellState(rawValue: Int(arc4random() % 2))!
}

func printBoard(board: Board) -> Void {
    print("Printing board \(board.cellValues.count)")
    for col in board.cellValues {
        for row in col {
            let strValue = .alive == row ? "x" : " "
            print("[\(strValue)]", terminator: "")
        }
        print("\n")
    }
}

let old = Board()
let new = Board()

for x in 0..<COLS {
    for y in 0..<ROWS {
        old.cellValues[x][y] = random()
    }
}

for x in 0..<COLS {
    for y in 0..<ROWS {
        new.cellValues[x][y] = old.cellValues[x][y]
    }
}

new.iterate()

printBoard(board: old)
printBoard(board: new)

