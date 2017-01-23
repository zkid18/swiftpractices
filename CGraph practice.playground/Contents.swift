//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


enum Primitive {
    case Rectangular
    case Elipse
    case Text(String)
}

enum Attribute {
    case FillColor(UIColor)
}

indirect enum Diagram {
    case Prim(CGSize, Primitive)
    case Beside(Diagram, Diagram)
    case Below(Diagram, Diagram)
    case Attributed(Attribute, Diagram)
    case Align(CGVector, Diagram)
}

class Draw: NSView {
    let diagram: Diagram
    
    init (frame frameRect: NSRect, diagram: Diagram) {
        self.diagram = diagram
        super.init(frame: frameRect)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func drawRect(dirtyRect: CGRect) {
        guard let currentContext = UIGrap .currentContext() else {return}
        
    }
}

extension Diagram {
    var size: CGSize {
        switch self {
        case Prim(let size, .Rectangular):
            let frame = size.fit(CGVector(dx: 0.5, dy: 0.5, bounds))
            CGContextFillRect(self, frame)
        case .Prim(let size, .Text(let text)):
            let frame = size.fit(CGVector(dx: 0.5, dy: 0.5), bounds)
            let font = UIFont.systemFontOfSize(12)
            let attributes = [NSFontAttributeName: font]
            let attributedText = NSAttributedString(string: text, attributes: attributes)
            attributes.drawnInRec(frame)
        case Attributed(.FillColor(let color), let d):
            CGContextSaveGState(self)
            color.set()
            draw(bounds,d)
            CGContextRestoreGState(self)
        case .Beside(let l, let r):
            let sizeL = l.size
            let sizeR = r.size
            return CGSizeMake(max(l.size.width, r.size.width),
                l.size.height + r.size.height
            )
        case .Beside(let left, let right):
            let (lFrame, rFrame) = bounds.split(
                left .size.width/diagram.size.width, edge: .MinXEdge)
            draw(lFrame, left)
            draw(rFrame, right)
        case .Below(let l, let r):
            return CGSizeMake(max(l.size.width, r.size.width),
                l.size.height + r.size.height)
        case .Below(let top, let bottom):
            let (lFrame, rFrame) = bounds.split(
                bottom.size.height/diagram.size.height, edge: .MinYEdge)
            draw(lFrame, bottom)
            draw(rFrame, top)
        case .Align(_, let r):
            return r.size
        case .Align(let vec, let diagram):
            let frame = diagram.size.fit(vec, bounds)
            draw(frame, diagram)
        default:
            break
        }
    }
}

func /(l: CGSize, r: CGSize) -> CGSize {
    return CGSize(width: l.width/r.width, height: l.height/r.height)
}

func *(l: CGSize, r: CGSize) -> CGSize {
    return CGSize(width: l.width*r.width, height: r.height*l.height)
}

func *(l: CGFloat, r: CGSize) -> CGSize {
    return CGSize(width: l*r.width, height: r.height)
}

func -(l: CGSize, r: CGSize) ->  CGSize {
    return CGSize(width: l.width - r.width, height: l.height - r.height)
}

func -(l: CGPoint, r: CGPoint) -> CGPoint {
    return CGPoint(x: l.x - r.x, y: l.y - r.y)
}

extension CGSize {
    var point: CGPoint {
        return CGPoint(x: self.point.x, y: self.point.y)
    }
}

extension CGRect {
    func split(ratio: CGFloat, edge: CGRectEdge) -> (CGRect, CGRect) {
        let length = edge.isHorisontal ? width: height
        return divide(length*ratio, fromEdge: edge)
    }
}

extension CGRectEdge {
    var isHorisontal: Bool {
        return self == .MaxXEdge || self == .MaxYEdge
    }
}

extension CGVector {
    var point: CGPoint { return CGPoint(x: dx, y: dy) }
    var size: CGSize {  return CGSize(width: dx, height: dy) }
}

extension CGSize {
    func fit(vector: CGVector, _ rect: CGRect) -> CGRect {
        let scaleSize = rect.size / self
        let scale = min(scaleSize.height, scaleSize.width)
        let size = scale * self
        let space = vector.size * (size - rect.size)
        return CGRect(origin: rect.origin - space.point, size: size)
        
    }
}



