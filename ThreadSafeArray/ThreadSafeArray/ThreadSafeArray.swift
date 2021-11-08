//
//  ThreadSafeArray.swift
//  ThreadSafeArray
//
//  Created by Red Beard on 07.11.2021.
//

import Foundation

struct ThreadSafeArray<Element: Hashable> {
    private var array: Array<Element> = []
    private let semaphore = DispatchSemaphore(value: 1)
    
    var isEmpty: Bool {
        semaphore.wait()
        let result = array.isEmpty
        semaphore.signal()
        return result
    }
    
    var count: Int {
        semaphore.wait()
        let result = array.count
        semaphore.signal()
        return result
    }
    
    mutating func append(_ item: Element) {
        semaphore.wait()
        array.append(item)
        semaphore.signal()
    }
    
    mutating func remove(at index: Int) {
        semaphore.wait()
        if 0 <= index && index < count {
            array.remove(at: index)
        }
        semaphore.signal()
    }
    
    subscript(index: Int) -> Element {
        semaphore.wait()
        let result = array[index]
        semaphore.signal()
        return result
    }
    
    func contains(_ element: Element) -> Bool {
        semaphore.wait()
        let result = array.contains(element)
        semaphore.signal()
        return result
    }
}
