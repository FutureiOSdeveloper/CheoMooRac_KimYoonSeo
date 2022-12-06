//
//  InsertionSort.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2022/11/25.
//

import Foundation

func insertionSort<T: Comparable>(_ array: [T]) -> [T] {
    var sort = array

    for i in 1..<array.count {
        var j = i
        let temp = sort[j]
        while j > 0 && temp < sort[j - 1] {
          sort[j] = sort[j - 1]
          j -= 1
        }

        sort[j] = temp
    }
    return sort
}

// isAscending: (T, T) -> Bool :
// 두 개의 T 객체를 받아서, 첫 번째 객체가 두 번째 것보다
// 앞에 위치하면 true를 반환하고, 그 반대라면 false를 반환하는 함수
func insertionSort<T: Comparable>(_ array: [T],
                                  _ isAscending: (T, T) -> Bool) -> [T] {
    var sort = array

    for i in 1..<array.count {
        var j = i
        let temp = sort[j]
        while j > 0 && temp < sort[j - 1] && isAscending(sort[j - 1], temp) {
          sort[j] = sort[j - 1]
          j -= 1
        }

        sort[j] = temp
    }
    return sort
}
