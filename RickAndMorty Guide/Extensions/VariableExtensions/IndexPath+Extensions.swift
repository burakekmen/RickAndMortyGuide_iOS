//
//  IndexPath+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

public extension IndexPath {
    /// The previous row's NSIndexPath. UITableView
    var previousRow: IndexPath {
        let indexPath = IndexPath(row: (self as NSIndexPath).row - 1, section: (self as NSIndexPath).section)
        return indexPath
    }

    /// The next row's NSIndexPath. UITableView
    var nextRow: IndexPath {
        let indexPath = IndexPath(row: (self as NSIndexPath).row + 1, section: (self as NSIndexPath).section)
        return indexPath
    }

    /// The previous item's NSIndexPath. UICollectionView
    var previousItem: IndexPath {
        let indexPath = IndexPath(item: (self as NSIndexPath).item - 1, section: (self as NSIndexPath).section)
        return indexPath
    }

    /// The next item's NSIndexPath. UICollectionView
    var nextItem: IndexPath {
        let indexPath = IndexPath(item: (self as NSIndexPath).item + 1, section: (self as NSIndexPath).section)
        return indexPath
    }

    /// The previous section. Both of UICollectionView and UITableView
    var previousSection: IndexPath {
        let indexPath = IndexPath(row: (self as NSIndexPath).row, section: (self as NSIndexPath).section - 1)
        return indexPath
    }

    /// The next section. Both of UICollectionView and UITableView
    var nextSection: IndexPath {
        let indexPath = IndexPath(row: (self as NSIndexPath).row, section: (self as NSIndexPath).section + 1)
        return indexPath
    }
}
