import Foundation
import UIKit
import PlaygroundSupport

class BoardView: UIView, BoardDelegate {
    var boardModel: Board?
    var boardCellViews = [[CellView]]()
    
    convenience init(ofBoard board:Board) {
        let cellSize = Int(CellView.Constants.cellSize)
        let rect = CGRect(x: 0, y: 0, width: board.columns*cellSize, height: board.rows*cellSize)
        self.init(frame: rect)
        boardModel = board
        boardModel?.delegate = self
        for i in 0..<board.rows {
            boardCellViews.append([CellView]())
            for j in 0..<board.columns {
                let size = CellView.Constants.cellSize
                let rect = CGRect(x: CGFloat(j)*size, y: CGFloat(i)*size, width: size, height: size)
                let cellView = CellView(frame: rect)
                cellView.alive = boardModel!.boardState[i][j]
                addSubview(cellView)
                boardCellViews[i].append(cellView)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red:0.41, green:0.10, blue:0.60, alpha:1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellDidChanged(column: Int, row: Int) {
        guard let boardModel = self.boardModel else {
            return
        }
        
        let cell = self.boardCellViews[column][row]
        cell.alive = boardModel.boardState[column][row]
    }
    
    @objc func nextGeneration() {
        self.boardModel?.nextGeneration()
    }
}
