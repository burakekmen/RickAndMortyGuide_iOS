//
//  UIGestureRecognizer.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 14.05.2022.
//

import UIKit

private var HandlerKey: UInt8 = 0

internal extension UIGestureRecognizer {

    func setHandler<T: UIGestureRecognizer>(_ instance: T, handler: ClosureHandler<T>) {
        objc_setAssociatedObject(self, &HandlerKey, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        handler.control = instance
    }

    func handler<T>() -> ClosureHandler<T> {
        return objc_getAssociatedObject(self, &HandlerKey) as! ClosureHandler
    }
}
