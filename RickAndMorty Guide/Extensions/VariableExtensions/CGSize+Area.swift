//
//  CGSize+Area.swift
//  RickAndMortyGuide
//
//  Created by Burak Ekmen on 16.05.2022.
//

import Foundation
import UIKit

extension CGSize {
    var area:CGFloat{
        let _area = width * height
        return _area
    }
    
    static func >= (lhs: CGSize, rhs: CGSize) -> Bool {
        let lhsArea = lhs.area
        let rhsArea = rhs.area
        return lhsArea >= rhsArea
    }
    
    static func > (lhs: CGSize, rhs: CGSize) -> Bool {
        let lhsArea = lhs.area
        let rhsArea = rhs.area
        return lhsArea > rhsArea
    }

    static func <= (lhs: CGSize, rhs: CGSize) -> Bool {
        return !(lhs > rhs)
    }

    static func < (lhs: CGSize, rhs: CGSize) -> Bool {
        return !(lhs >= rhs)
    }

    static func * (size: CGSize, ratio: CGFloat) -> CGSize {
        let newWidth = size.width * ratio
        let newHeight = size.height * ratio
        return CGSize(width: newWidth, height: newHeight)
    }
    
    var isLandscape:Bool{
        return width > height
    }
    
    var isPortrait:Bool{
        return !isLandscape
    }
}
