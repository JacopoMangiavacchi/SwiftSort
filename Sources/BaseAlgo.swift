//
//  Swift Stack, Queue array and utilities
//
//  Created by Jacopo Mangiavacchi on 10/30/16.
//
//

import Foundation
//import QuartzCore

//UTILITY
//func executionTime(block: ()->()) -> CFTimeInterval {
//    let start = CACurrentMediaTime()
//    block()
//    let end = CACurrentMediaTime()
//    return end - start
//}

func executionTime(block: ()->()) -> TimeInterval {
    let start = Date()
    block()
    return Date().timeIntervalSince(start)
}


func createRandomIntArray(_ n: Int)  -> [Int] {
    var array = Array<Int>()
    
    for _ in 0..<n {
        var notFound = false
        repeat {
            #if os(Linux)
                let r = Int(random()) % n
            #else
                let r = Int(arc4random()) % n
            #endif

            if array.index(of: r) == nil {
                notFound = true
                array.append(r)
            }
        } while notFound == false
    }
    
    return array
}



//STACK ARRAY
struct Stack<T> {
    
    var stack = [T]()
    var count:Int { return stack.count }

    mutating func push(_ value: T) {
        stack.insert(value, at: 0)
    }
    
    mutating func pop() -> (T?) {
        return stack.remove(at: 0)
    }
}

extension Stack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var curr = self
        return AnyIterator {
            _ -> T? in
            return curr.pop()
        }
    }
}

//QUEUE ARRAY
struct Queue<T> {

    var queue:[T] = []
    var count:Int { return queue.count }

    mutating func enqueue(_ value: T) {
        queue.append(value)
    }

    mutating func dequeue() -> (T?) {
        return queue.count > 0 ? queue.remove(at: 0) : nil
    }

    func head() -> (T?) {
        return queue.count > 0 ? queue[0] : nil
    }

    func isEmpty() -> Bool {
        return queue.isEmpty
    }
}

extension Queue: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var curr = self
        return AnyIterator {
            _ -> T? in
            return curr.dequeue()
        }
    }
}

//HEAP
typealias Heap<T: Comparable> = PriorityQueue<T>
struct PriorityQueue<T: Comparable> {
    
    var queue:[T] = []
    var count:Int { return queue.count }
    
    init() {}
    
    init(fromArray:[T]) {
        queue = fromArray
        
        for i in stride(from: queue.count-1, to: -1, by: -1) {
            boubleDown(i)
        }
    }
    
    mutating func enqueue(_ value: T) {
        queue.append(value)
        
        var pos = queue.count - 1
        while true {
            let par = parent(pos)
            if par >= 0 && queue[par] > queue[pos] {
                let tmp = queue[par]
                queue[par] = queue[pos]
                queue[pos] = tmp
                pos = par
            }
            else {
                break
            }
        }
    }
    
    mutating internal func boubleDown(_ pos: Int) {
        var minChildPos = left(pos)
        
        if minChildPos < queue.count {
            let rightPos = right(pos)
            
            if rightPos < queue.count {
                if queue[rightPos] < queue[minChildPos] {
                    minChildPos = rightPos
                }
            }
            
            if queue[pos] > queue[minChildPos] {
                let tmp = queue[pos]
                queue[pos] = queue[minChildPos]
                queue[minChildPos] = tmp
                
                boubleDown(minChildPos)
            }
        }
    }
    
    mutating func dequeue() -> (T?) {
        let top:T? = queue.count > 0 ? queue[0] : nil
        
        if top != nil {
            let lastValue = queue.remove(at: queue.count - 1)
            
            if queue.count > 0 {
                queue[0] = lastValue
                
                boubleDown(0)
            }
        }
        
        return top
    }
    
    func peek() -> (T?) {
        return queue.count > 0 ? queue[0] : nil
    }
    
    internal func left(_ n: Int) -> Int {
        return 2 * n + 1
    }
    
    internal func right(_ n: Int) -> Int {
        return 2 * n + 2
    }
    
    internal func parent(_ n: Int) -> Int {
        return (n - 1) / 2
    }
}
