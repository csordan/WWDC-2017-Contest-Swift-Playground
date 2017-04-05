import Foundation
import UIKit

class CellView: UIView{
    var alive = true {
        didSet{
            animate()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.33, initialSpringVelocity: 0.0, options: [], animations: {
            self.isHidden = !self.alive
        }, completion: nil)
    }
    
    override func draw(_ rect: CGRect) {
        backgroundColor = .clear
        
        let lineWidth = Constants.lineWidth
        let size = Constants.circleSize
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:size/2,y:size/2),
            radius: CGFloat(size/2 - (lineWidth/2) ),
            startAngle: CGFloat(0),
            endAngle:CGFloat(M_PI * 2),
            clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = Constants.fillColor.cgColor
        shapeLayer.lineWidth = lineWidth
        
        layer.addSublayer(shapeLayer)
    }
    
    struct Constants {
        private init(){}
        static let circleSize:CGFloat = 9
        static let cellSize:CGFloat = 5
        static let fillColor = UIColor(red:0.41, green:0.94, blue:0.68, alpha:1.0)
        static let lineWidth:CGFloat = 1
    }
}
