//
//  UIScrollView+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

extension UIScrollView {

    enum ScrollDirection {
        case up, down, unknown
    }

    var customScrollDirection: ScrollDirection {
        guard let superview = superview else { return .unknown }
        return panGestureRecognizer.translation(in: superview).y > 0 ? .down : .up
    }

    func makeDefaultScrollView(bounces: Bool = true) -> UIScrollView {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.contentInsetAdjustmentBehavior = .never
        self.bounces = bounces
        return self
    }

    func createConstraintsWithContentView(topView: UIView? = nil,
                                          parentView: UIView,
                                          contentView: UIView,
                                          topMargin: CGFloat = 0.0,
                                          bottomOffset: CGFloat = -36.0) {
        self.snp.makeConstraints { (maker) in
            if let topView = topView {
                maker.top.equalTo(topView.snp.bottom).offset(topMargin)
            } else {
                maker.topSafeArea(view: parentView)
            }
            maker.bottomSafeaArea(view: parentView)
            maker.leading.trailing.equalTo(parentView)
        }

        contentView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self)
            maker.bottom.equalTo(self).offset(bottomOffset)
            maker.left.right.equalTo(parentView)
            maker.width.equalTo(parentView)
            maker.height.equalTo(parentView).priority(250.0)
        }
    }

    var isScrollToTop: Bool {
        let topEdge = 0 - contentInset.top
        return contentOffset.y <= topEdge
    }

    var isScrollToBottom: Bool {
        let bottomEdge = contentSize.height + contentInset.bottom - bounds.height
        return contentOffset.y >= bottomEdge
    }
    
    var isAvailablePagination: Bool {
        if contentSize.height == 0 { return false }
        let height = frame.size.height
        let contentYoffset = contentOffset.y
        let distanceFromBottom = contentSize.height - contentYoffset
        return distanceFromBottom < height
    }

    func scrollToTop(animated: Bool = false) {
        let desiredOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: animated)
    }

}
