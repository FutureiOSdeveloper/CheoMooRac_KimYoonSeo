//
//  QuickSort.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2022/11/24.
//

import Foundation

extension Array where Element: Equatable & Comparable {
    func quicksort(comparison: ((Element, Element) -> Bool)) -> [Element] {
        var copy = self
        copy.quick(0, count - 1, comparison: comparison)
        return copy
    }

    mutating private func quick(_ i: Int, _ j: Int, comparison: ((Element, Element) -> Bool)) {
        guard i < j else {
            return
        }
        let pivot = partition(i, j, comparison: comparison)
        quick(i, pivot - 1, comparison: comparison)
        quick(pivot + 1, j, comparison: comparison)
    }

    mutating private func partition(_ i: Int, _ j: Int, comparison: ((Element, Element) -> Bool)) -> Int {
        let pivotElement = self[j]
        var indexToAdd = i - 1
        for k in i..<j {
            if comparison(self[k], pivotElement) {
                indexToAdd += 1
                swapAt(indexToAdd, k)
            }
        }
        swapAt(indexToAdd + 1, j)
        return indexToAdd + 1
    }
}
