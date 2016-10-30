import XCTest
@testable import SwiftSort

class SwiftSortTests: XCTestCase {

    typealias SortFunction = (inout [Int]) -> () -> ()

    let arraySize = 1000

    func sortTest(testName: String, arraySize: Int, sortF: @escaping SortFunction) -> Bool {
        var array:Array<Int> = createRandomIntArray(arraySize)
        let t = executionTime { sortF(&array)() }
        let s = array.isSorted()

        #if os(Linux)
            let r = Int(random()) % array.count
        #else
            let r = Int(arc4random()) % array.count
        #endif
 
        let c = array.binarySearch(r)

        print("\(testName)  result: \(s)  check: \(c)  in: \(t)")

        return c
    }

    func bucketsortTest(testName: String, arraySize: Int) -> Bool {
        var array:Array<Int> = createRandomIntArray(arraySize)
        let t = executionTime { array.bucketSort(maxValue: arraySize) }
        let s = array.isSorted()

        #if os(Linux)
            let r = Int(random()) % array.count
        #else
            let r = Int(arc4random()) % array.count
        #endif
 
        let c = array.binarySearch(r)

        print("\(testName)  result: \(s)  check: \(c)  in: \(t)")

        return c
    }


    func testBucketSort() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(bucketsortTest(testName: "bucketSort   ", arraySize: arraySize), true)
    }

    func testRadixSort() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(sortTest(testName: "radixSort    ", arraySize: arraySize, sortF: Array<Int>.radixSort), true)
    }

    func testQuickSort() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(sortTest(testName: "quickSort    ", arraySize: arraySize, sortF: Array<Int>.quickSort), true)
    }

    func testHeapSort() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(sortTest(testName: "heapSort     ", arraySize: arraySize, sortF: Array<Int>.heapSort), true)
    }

    func testMergeSort() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(sortTest(testName: "mergeSort    ", arraySize: arraySize, sortF: Array<Int>.mergeSort), true)
    }

    func testSelectionSort() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(sortTest(testName: "selectionSort", arraySize: arraySize, sortF: Array<Int>.selectionSort), true)
    }

    func testInsertionSort() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(sortTest(testName: "insertionSort", arraySize: arraySize, sortF: Array<Int>.insertionSort), true)
    }

    func testBubbleSort() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(sortTest(testName: "bubbleSort   ", arraySize: arraySize, sortF: Array<Int>.bubbleSort), true)
    }




    static var allTests : [(String, (SwiftSortTests) -> () throws -> Void)] {
        return [
            ("bucketSort", testBucketSort),
            ("radixSort", testRadixSort),
            ("quickSort", testQuickSort),
            ("heapSort", testHeapSort),
            ("mergeSort", testMergeSort),
            ("selectionSort", testSelectionSort),
            ("insertionSort", testInsertionSort),
            ("bubbleSort", testBubbleSort),
        ]
    }
}
