import Foundation
import PlaygroundSupport

public class World {
    static var boardView: BoardView?
    static var timer:Timer?
    
    public static func create(columns:Int, rows:Int) {
        let board = Board(columns: columns, rows: rows)
        board.randomize()
        boardView = BoardView(ofBoard:board)
        PlaygroundPage.current.liveView = boardView
        PlaygroundPage.current.needsIndefiniteExecution = true
        
    }
    
    public static func startLife(oneGenerationDuration duration: Double){
        Timer.scheduledTimer(withTimeInterval: TimeInterval(duration), repeats: true, block: { _ in
            self.boardView?.nextGeneration()
        })
        
        PlaygroundPage.current.liveView = boardView
        PlaygroundPage.current.needsIndefiniteExecution = true
    }
}
