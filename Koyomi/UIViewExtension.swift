//
//  UIViewExtension.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/22.
//
//

import UIKit

extension UIView {
    
    enum RectCornerType { case left, right, none }
    
    func mask(with style: RectCornerType) {
        let corner: UIRectCorner = {
            switch style {
            case .left:  return [.topLeft, .bottomLeft]
            case .none:  return []
            case .right: return [.topRight, .bottomRight]
            }
        }()
        
        let path: UIBezierPath = .init(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: bounds.width / 2, height: bounds.height / 2))
        
        let maskLayer: CAShapeLayer = .init()
        maskLayer.frame = bounds
        maskLayer.path  = path.cgPath
        layer.mask = corner.isEmpty ? nil : maskLayer
    }
}
