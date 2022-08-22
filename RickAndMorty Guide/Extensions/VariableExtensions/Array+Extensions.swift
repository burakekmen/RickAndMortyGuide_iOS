//
//  Array+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension Array {

    subscript(indexPath: IndexPath) -> Element {
        self[indexPath.row]
    }
    
    /// array'inizde istedğiniz counta kadar elemanları çekip yeni bir array olarak gönder
    /// verilen count, arrayin countundan büyükse, arrayin kendisini geri döndürür.
    func takeItemsWithoutNulls(newItemCounts: Int) -> Array {
        if newItemCounts > count {
            return self
        }
        return enumerated().compactMap { $0.offset < newItemCounts ? $0.element: nil }
    }

    mutating func move(from oldIndex: Index, to newIndex: Index) {
        if oldIndex == newIndex { return }
        if abs(newIndex - oldIndex) == 1 { return self.swapAt(oldIndex, newIndex) }
        self.insert(self.remove(at: oldIndex), at: newIndex)
    }
}

extension Array where Element: Equatable {

    func indexes(of item: Element) -> [Int]  {
        return enumerated().compactMap { $0.element == item ? $0.offset : nil }
    }
}

extension Array where Element: Hashable {

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }

    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}
