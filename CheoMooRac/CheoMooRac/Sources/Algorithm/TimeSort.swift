//
//  Sort.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2022/11/22.
//

import Foundation

extension Array where Element: Comparable {

    func bubbleSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        var data = self
        guard data.count != 0 else { return self }

        for i in 0..<(data.count-1) { // 1
            for j in 0..<(data.count-i-1) where areInIncreasingOrder(data[j+1], data[j]) { // 2
                data.swapAt(j, j + 1)
            }
        }

        return data
    }
}

func swap<T: Comparable>(left: inout T, right: inout T) {
    print("Swapping \(left) and \(right)")
    let temp = right
    right = left
    left = temp
}

extension Array where Element: Comparable {

    private func _quickSort(_ array: [Element], by areInIncreasingOrder: ((Element, Element) -> Bool)) -> [Element] {
        if array.count < 2 { return array } // 0

        var data = array

        let pivot = data.remove(at: 0) // 1
        let left = data.filter { areInIncreasingOrder($0, pivot) } // 2
        let right = data.filter { !areInIncreasingOrder($0, pivot) } // 3
        let middle = [pivot]

        return _quickSort(left, by: areInIncreasingOrder) + middle + _quickSort(right, by: areInIncreasingOrder) // 4
    }

    func quickSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        return _quickSort(self, by: areInIncreasingOrder)
    }
}

extension Array where Element: Comparable {
    func selectionSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        var data = self
        guard data.count != 0 else { return self }

        for i in 0..<(data.count-1) {
            var key = i // 1

            for j in i+1..<data.count where areInIncreasingOrder(data[j], data[key]) { // 2
                key = j
            }

            guard i != key else { continue }

            data.swapAt(i, key) // 3
        }

        return data
    }
}
