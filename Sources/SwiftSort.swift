//
//  Swift Sort Algorithms implemented as Array extensions
//
//  Created by Jacopo Mangiavacchi on 10/30/16.
//
//

import Foundation

//SORT

extension Array where Element : Comparable {
    internal mutating func swap(_ a: Int, _ b: Int) {
        if a != b {
            (self[a], self[b]) = (self[b], self[a])
        }
    }
    
    //n
    func isSorted() -> Bool {
        for i in 0..<self.count-1 {
            if self[i] > self[i+1] {
                return false
            }
        }
        return true
    }
    
    //nlogn
    func binarySearch(_ element: Element) -> Bool {
        guard self.count > 0 else {
            return false
        }
        
        let middle = self.count / 2
        let middleElement = self[middle]
        
        if element == middleElement {
            return true
        }
        else if element < middleElement {
            return Array(self[0..<middle]).binarySearch(element)
        }
        else {
            return Array(self[middle+1..<self.count]).binarySearch(element)
        }
    }
    
    
    //nˆ2
    mutating func bubbleSort() {
        for i in 0..<self.count {
            for j in i+1..<self.count {
                if self[j] < self[i] {
                    swap(i, j)
                }
            }
        }
    }
    
    //nˆ2
    mutating func selectionSort() {
        for i in 0..<self.count {
            var min = i
            for j in i+1..<self.count {
                if self[j] < self[min] {
                    min = j
                }
            }
            if i != min {
                swap(i, min)
            }
        }
    }
    
    //nˆ2
    mutating func insertionSort() {
        for i in 0..<self.count {
            var j = i
            while j>0 && self[j] < self[j-1] {
                swap(j, j-1)
                j -= 1
            }
        }
    }
    
    //nlogn
    mutating func quickSort() {
        func partition(from: Int, to: Int) -> Int {
            let p = self[(from+to)/2] // or random
            //print("\(from)-\(to)=>\(p)")
            
            var left = from
            var right = to
            
            while left<=right {
                while self[left] < p {
                    left += 1
                }
                while self[right] > p {
                    right -= 1
                }
                
                if left<=right {
                    (self[left], self[right]) = (self[right], self[left])
                    left += 1
                    right -= 1
                }
            }
            
            return left
        }
        
        func quickSort(from: Int, to: Int) {
            if to-from > 0 {
                let p = partition(from: from, to: to)
                quickSort(from: from, to: p-1)
                quickSort(from: p, to: to)
            }
        }
        
        quickSort(from: 0, to: self.count-1)
    }

    
    //nlogn
    mutating func mergeSort()  {
        func mergeSort(low: Int, high: Int) {
            let middle = (low+high)/2
            
            if high-low > 1 {
                mergeSort(low: low, high: middle)
                mergeSort(low: middle+1, high: high)
            }
            merge(low: low, middle: middle, high: high)
        }
        func merge(low: Int, middle: Int, high: Int) {
            guard low != middle || middle != high else {
                return
            }
            
            var leftQ = Queue<Element>()
            var rightQ = Queue<Element>()
            
            for i in low...middle {
                leftQ.enqueue(self[i])
            }
            for i in middle+1...high {
                rightQ.enqueue(self[i])
            }
            
            var i = low
            while !leftQ.isEmpty() && !rightQ.isEmpty() {
                if leftQ.head()! < rightQ.head()! {
                    self[i] = leftQ.dequeue()!
                }
                else {
                    self[i] = rightQ.dequeue()!
                }
                i += 1
            }
            while let left =  leftQ.dequeue() {
                self[i] = left
                i += 1
            }
            while let right =  rightQ.dequeue() {
                self[i] = right
                i += 1
            }
        }
    
        mergeSort(low: 0, high: self.count-1)
    }

    //nlogn
    mutating func heapSort() {
        var heap = PriorityQueue<Element>(fromArray: self)
        
        var i = 0
        while let e = heap.dequeue() {
            self[i] = e
            i += 1
        }
    }
}



//Swift 3.1
//extension Array where Element == Int {
extension Array where Element : Integer {
    //n
    //bucketSort (only for Int array)
    mutating func bucketSort(maxValue: Int) {
        var bucketArray = Array<Int>(repeating: 0, count: maxValue)
        
        for i in 0..<self.count {
            bucketArray[self[i] as! Int] += 1
        }
        
        var pos = 0
        for i in 0..<bucketArray.count {
            if bucketArray[i] > 0 {
                for _ in 0..<bucketArray[i] {
                    self[pos] = i as! Element
                    pos += 1
                }
            }
        }
    }
    
    //nlogn
    //radixSort
    mutating func radixSort() {
        var divide = 1
        var big=0
        
        while true {
            var bucketArray = Array<[Int]>(repeating: [Int](), count: 10)
            
            for i in 0..<self.count {
                let n = self[i] as! Int
                bucketArray[n / divide % 10].append(n)
                if n > big {
                    big = n
                }
            }
            
            var pos = 0
            for bucket in bucketArray {
                for i in bucket {
                    self[pos] = i as! Element
                    pos += 1
                }
            }
            
            if big < divide * 10 {
                break
            }
            
            divide *= 10
        }
    }
}
