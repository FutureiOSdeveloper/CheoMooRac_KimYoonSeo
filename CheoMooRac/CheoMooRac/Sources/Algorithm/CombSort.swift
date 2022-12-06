//
//  CombSort.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2022/11/24.
//


import Foundation

public func combSort<T: Comparable>(_ input: [T]) -> [T] {
    var copy: [T] = input
    var gap = copy.count
    let shrink = 1.3

    while gap > 1 {
        gap = (Int)(Double(gap) / shrink)
        if gap < 1 {
            gap = 1
        }

        var index = 0
        while !(index + gap >= copy.count) {
            if copy[index] > copy[index + gap] {
                copy.swapAt(index, index + gap)
            }
            index += 1
        }
    }
    return copy
}

fileprivate func swap<T: Comparable>(a: inout T, b: inout T) {
    let temp = a
    a = b
    b = temp
}
