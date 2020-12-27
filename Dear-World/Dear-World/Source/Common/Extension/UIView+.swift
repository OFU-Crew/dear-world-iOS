//
//  UIView+.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/27.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path: UIBezierPath = UIBezierPath(roundedRect: bounds,
                                              byRoundingCorners: corners,
                                              cornerRadii: CGSize(width: radius, height: radius))
        let mask: CAShapeLayer = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
