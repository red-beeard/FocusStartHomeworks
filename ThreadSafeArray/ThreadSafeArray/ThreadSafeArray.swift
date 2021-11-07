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
        array.isEmpty
    }
    
    var count: Int {
        array.count
    }
    
    mutating func append(_ item: Element) {
        semaphore.wait()
        array.append(item)
        semaphore.signal()
    }
    
    mutating func remove(at index: Int) {
        if 0 <= index && index < count {
            semaphore.wait()
            array.remove(at: index)
            semaphore.signal()
        }
    }
    
    subscript(index: Int) -> Element {
        array[index]
    }
    
    func contains(_ element: Element) -> Bool {
        array.contains(element)
    }
}
