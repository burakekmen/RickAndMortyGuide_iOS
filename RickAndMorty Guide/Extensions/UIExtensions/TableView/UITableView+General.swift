//
//  UITableView+General.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

extension UITableView {

    /**
         Last indexPath in section
         
         - parameter section: section
         
         - returns: NSIndexPath
         */
    func lastIndexPathInSection(_ section: Int) -> IndexPath? {
        return IndexPath(row: self.numberOfRows(inSection: section) - 1, section: section)
    }

    /// Last indexPath in UITableView
    var lastIndexPath: IndexPath? {
        if (self.totalRows - 1) > 0 {
            return IndexPath(row: self.totalRows - 1, section: self.numberOfSections)
        } else {
            return nil
        }
    }

    /// Total rows in UITableView
    var totalRows: Int {
        var i = 0
        var rowCount = 0
        while i < self.numberOfSections {
            rowCount += self.numberOfRows(inSection: i)
            i += 1
        }
        return rowCount
    }

    /**
         Remove table header view
         */
    func removeTableHeaderView() {
        self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: 0.1))
    }

    /**
         Remove table footer view
         */
    func removeTableFooterView() {
        self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: 0.1))
    }

    /**
         Scroll to the bottom
         
         - parameter animated: animated
         */
    func scrollToBottom(_ animated: Bool) {
        let section = self.numberOfSections - 1
        let row = self.numberOfRows(inSection: section) - 1
        if section < 0 || row < 0 {
            return
        }
        let path = IndexPath(row: row, section: section)
        let offset = contentOffset.y
        self.scrollToRow(at: path, at: .top, animated: animated)
        let delay = (animated ? 0.1 : 0.0) * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: { () -> Void in
            if self.contentOffset.y != offset {
                self.scrollToBottom(false)
            }
        })
    }

    /**
         Scroll to the bottom without flashing
         */
    func ts_scrollBottomWithoutFlashing() {
        guard let indexPath = self.lastIndexPath else {
            return
        }
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.scrollToRow(at: indexPath, at: .bottom, animated: false)
        CATransaction.commit()
        UIView.setAnimationsEnabled(true)
    }

    /**
         Reload data without flashing
         */
    func ts_reloadWithoutFlashing() {
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.reloadData()
        CATransaction.commit()
        UIView.setAnimationsEnabled(true)
    }

    /**
         Fetch indexPaths of UITableView's visibleCells
         
         - returns: NSIndexPath Array
         */
    func ts_visibleIndexPaths() -> [IndexPath] {
        var list = [IndexPath]()
        for cell in self.visibleCells {
            if let indexPath = self.indexPath(for: cell) {
                list.append(indexPath)
            }
        }
        return list
    }

    /**
         Reload data with completion block
         
         - parameter completion: completion block
         */
    func ts_reloadData(_ completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() }, completion: { _ in completion() })

    }

}
