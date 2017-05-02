//
//  UIViewExtension.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/22.
//
//

import UIKit

extension UIView {
    
    enum EdgeDirection { case left, right, none }
    
    func mask(with style: EdgeDirection) {
        let center = style.center(of: bounds)
        let path: UIBezierPath = .init()
        path.move(to: center)
        path.addArc(withCenter: center, radius: bounds.height / 2, startAngle: style.angle.start, endAngle: style.angle.end, clockwise: style.isClockwise)
        
        let maskLayer: CAShapeLayer = .init()
        maskLayer.frame = bounds
        maskLayer.path  = path.cgPath
        layer.mask = style == .none ? nil : maskLayer
    }
}

extension UIView.EdgeDirection {
    var angle: (start: CGFloat, end: CGFloat) {
        switch self {
        case .left, .right: return (start: .pi + (.pi / 2), end: .pi / 2)
        case .none: return (start: 0, end: 0)
        }
    }
    
    var isClockwise: Bool {
        switch self {
        case .left: return false
        default:    return true
        }
    }
    
    func center(of bounds: CGRect) -> CGPoint {
        switch self {
        case .left: return CGPoint(x: bounds.width, y: bounds.height / 2)
        default:    return CGPoint(x: 0, y: bounds.height / 2)
        }
    }
}
