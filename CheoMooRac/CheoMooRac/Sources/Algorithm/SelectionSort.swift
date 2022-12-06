//
//  SelectionSort.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2022/11/24.
//

import Foundation

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
