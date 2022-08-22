//
//  RAMTabbar.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import Foundation
import UIKit

@IBDesignable
public final class RAMTabbar: UITabBar {

    @IBInspectable public var tabbarColor: UIColor = .white
    @IBInspectable public var selectedItemColor: UIColor = .white
    @IBInspectable public var unselectedItemColor: UIColor = .white

    private var shapeLayer: CALayer?

    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = tabbarColor.cgColor
        shapeLayer.lineWidth = 0

        // shadow
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0.5)
        shapeLayer.shadowRadius = 5
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.25

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
        self.tintColor = selectedItemColor
        self.unselectedItemTintColor = unselectedItemColor
    }

    override public func draw(_ rect: CGRect) {
        self.addShape()
    }

    private func createPath() -> CGPath {
        let height: CGFloat = CGFloat(24).adjustWidthRespectToDesignRate()
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2

        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - (height * 1.1)), y: 0))

        // complete the rect
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()

        return path.cgPath
    }
}

extension RAMTabbar {

    func makeDefaultAppStyle() {
        tabbarColor = .episodeTabColor
        selectedItemColor = .blackColor
        unselectedItemColor = .gray128
    }
}
