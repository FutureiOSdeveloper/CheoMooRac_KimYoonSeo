//
//  MergeSort.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2022/11/24.
//

import Foundation

extension Array where Element: Equatable & Comparable {
    func mergesort(comparison: ((Element, Element) -> Bool)) -> [Element] {
        return merge(0, count - 1, comparison: comparison)
    }

    private func merge(_ i: Int, _ j: Int, comparison: ((Element, Element) -> Bool)) -> [Element] {
        guard i <= j else {
            return []
        }
        guard i != j else {
            return [self[i]]
        }
        let half = i + (j - i) / 2
        let left = merge(i, half, comparison: comparison)
        let right = merge(half + 1, j, comparison: comparison)
        var i1 = 0
        var i2 = 0
        var new = [Element]()
        new.reserveCapacity(left.count + right.count)
        while i1 < left.count && i2 < right.count {
            if comparison(right[i2], left[i1]) {
                new.append(right[i2])
                i2 += 1
            } else {
                new.append(left[i1])
                i1 += 1
            }
        }
        while i1 < left.count {
            new.append(left[i1])
            i1 += 1
        }
        while i2 < right.count {
            new.append(right[i2])
            i2 += 1
        }
        return new
    }
}
