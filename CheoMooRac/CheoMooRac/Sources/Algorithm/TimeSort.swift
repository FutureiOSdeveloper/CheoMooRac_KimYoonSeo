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

extension Array where Element == Int {
    func bucketSort(reverse: Bool = false) -> [Element] {
        let data = self

        guard data.count > 0 else { return [] }

        let max = data.max()!
        var buckets = [Int](repeating: 0, count: (max + 1))
        var out = [Int]()

        for i in 0..<data.count {
            buckets[data[i]] = buckets[data[i]] + 1
        }

        buckets.enumerated().forEach { index, value in
            guard value > 0 else { return }

            out.append(contentsOf: [Int](repeating: index, count: value))
        }

        return reverse == true ? out.reversed() : out
    }
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


extension Array {
    mutating func insertionSort(by comparer: (Element, Element) -> Bool) {
        insertionSort(0, count, by: comparer)
    }

    private mutating func insertionSort(_ begin:Int, _ end: Int, by comparer: (Element, Element) -> Bool) {

        for i in begin..<end {
            for j in stride(from: i, to: 0, by: -1) {
                if !comparer(self[j],self[j-1]) {
                    break
                }
                self.swapAt(j, j-1)
            }
        }
    }

}

extension Array {
     mutating func mergeSort(by comparer: (Element, Element) -> Bool) {
         _mergeSort(0, count, by: comparer)
     }

     private mutating func _mergeSort(_ start: Int, _ end:Int, by comparer: (Element, Element) -> Bool) {
         let range = end - start
         if range < 2 {
             return
         }

         let mid = (start + end) / 2
         _mergeSort(start, mid, by: comparer)
         _mergeSort(mid, end, by: comparer)
         merge(start, end, by:comparer)
     }

     private mutating func merge(_ start:Int, _ end: Int, by comparer: (Element, Element) -> Bool ){
         self.insertionSort(start, end, by: comparer)
     }
 }

extension Array where Element == Range<Int> { // RunStack에서 이용하는 메소드
     mutating func mergeRuns(_ merging: (Range<Int>) -> Void) {
         while count > 1 {
             var lastIndex = count - 1


             if lastIndex >= 3,
                 self[lastIndex - 3].count <= self[lastIndex-2].count + self[lastIndex-1].count
             {
                 if self[lastIndex - 2].count < self[lastIndex].count {
                     lastIndex -= 1
                 }
             } else if lastIndex >= 2,
                 self[lastIndex - 2].count <= self[lastIndex - 1].count + self[lastIndex].count {
                 if self[lastIndex - 2].count < self[lastIndex].count {
                 lastIndex -= 1
                 }
             } else if self[lastIndex - 1].count <= self[lastIndex].count {
                 // 바로 머지한다
             } else {
                 break
             }

             let mergedX = self.remove(at: lastIndex)
             let mergedY = self.remove(at: lastIndex-1)

             let merged = mergedY.lowerBound..<mergedX.upperBound
             merging(merged)

             self.insert(merged, at: lastIndex-1)
         }
     }

     private mutating func mergeAll(_ merging: (Range<Int>) -> Void) {
         while count > 1 {
             let mergedX = self.removeLast()
             let mergedY = self.removeLast()

             let merged = mergedY.lowerBound..<mergedX.upperBound
             merging(merged)
             self.append(merged)
         }
     }
 }

 extension Array { // TimSort 본체에서 이용하는 메소드와 프로퍼티들
     private var minRun: Int {
     let bitsToUse = 6

     if count < 1 << bitsToUse {
         return count
     }

         let offset = (Int.bitWidth - bitsToUse) - count.leadingZeroBitCount
         let mask = (1 << offset) - 1
         return count >> offset + (count & mask == 0 ? 0 : 1)
     }

     private func getRun(_ start: Int, by comparer: (Element, Element) -> Bool) -> (Bool, Int){
         guard start < count - 1 else {
             return (true, count)
         }

         let isDescending = comparer(self[start+1], self[start])

         var previous = start
         var current = start + 1
         repeat {
             previous = current
             current += 1
         } while current < count &&
         isDescending == comparer(self[current],self[previous])

         return (isDescending, current)
     }

     private mutating func reverse(_ start: Int, _ end: Int) {
         var start = start
         var end = end
         while start < end {
             swapAt(start, end)
             start += 1
             end -= 1
         }
     }

     mutating func timSort(by comparer: (Element, Element) -> Bool) {
         if count <= minRun {
             insertionSort(by: comparer)
         } else {
             timSort(0, count, by: comparer)
         }
     }

     private mutating func timSort(_ start: Int, _ end: Int, by comparer: (Element, Element) -> Bool) {

         let minRun = self.minRun
         var runStack: [Range<Int>] = []

         var start = startIndex

         while start < endIndex {
             var (isDescending, end) = getRun(start, by: comparer)

             if isDescending {
                 reverse(start, end)
             }

             if end < endIndex, end - start < minRun {
                 let newEnd = Swift.min(endIndex, start+minRun)

                 insertionSort(start, newEnd, by: comparer)
                 end = newEnd
             }

             runStack.append(start..<end)
             runStack.mergeRuns {
                 merge($0.lowerBound, $0.upperBound, by: comparer)
             }

             start = end
         }

         runStack.mergeAll {
             merge($0.lowerBound, $0.upperBound, by: comparer)
         }
     }
 }
