import Foundation

public protocol BoardDelegate {
    func cellDidChanged(column:Int, row:Int)
}

public class Board {
    var boardState: [[Bool]]
    var delegate: BoardDelegate?
    let columns: Int
    let rows: Int
    
    var currentGeneration = 0
    
    var archivedStates = [String]()
    
    public init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        self.boardState = Array(repeating: Array(repeating: false, count: columns), count: rows)

    }
    
    
    public func randomize() {
        for x in 0..<rows {
            for y in 0..<columns {
                boardState[x][y] = (arc4random() % 3 == 0)
                delegate?.cellDidChanged(column: x, row: y)
            }
        }
    }
    
    func liveOrDie(posX: Int, posY: Int) -> Bool {
        var q = 0
        let alive = boardState[posX][posY]
        let xRange = max(0, posX-1)..<min(rows, posX+2)
        let yRange = max(0, posY-1)..<min(columns, posY+2)
        for x in xRange {
            for y in yRange {
                if(!(x == posX && y == posY) && boardState[x][y]) {
                    q+=1
                }
                if(alive && q > 3) {
                    return false
                }
            }
        }
        return (alive && q == 2 || q == 3) || (!alive && q == 3)
    }
    
    public func nextGeneration() {
        var newState = Array(repeating: Array(repeating: false, count: columns), count: rows)
        
        for x in newState.indices {
            for y in newState[x].indices {
                newState[x][y] = liveOrDie(posX: x, posY: y)
                delegate?.cellDidChanged(column: x, row: y)
            }
        }
        
        let newString = Board.stringRepresentation(ofState: newState)
        let currentString = Board.stringRepresentation(ofState: boardState)
        archivedStates.append(currentString)
        if archivedStates.count == 5 {
            archivedStates.removeFirst()
        }
        
        if isStucked(newState: newString) {
            randomize()
            currentGeneration = 0
            archivedStates = []
        } else {
            currentGeneration+=1
            boardState = newState
        }
    }

    func isStucked(newState:String) -> Bool {
        return archivedStates.contains(newState)
    }
    
    public static func stringRepresentation(ofState state:[[Bool]]) -> String {
        return state.map { (row) -> String in
            row.map { (b) -> String in
                if(b) { return "*" } else { return " " }
                }.joined(separator: "")
            }.joined(separator: "\n")
    }
}
