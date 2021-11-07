//
//  main.swift
//  ThreadSafeArray
//
//  Created by Red Beard on 07.11.2021.
//

import Foundation

func addingNumbers(to array: inout ThreadSafeArray<Int>) {
    for number in 1...1000 {
        array.append(number)
    }
}

var integers = ThreadSafeArray<Int>()

let queue = DispatchQueue(label: "concurrentQueue", qos: .userInitiated, attributes: .concurrent)
let group = DispatchGroup()

queue.async(group: group) {
    addingNumbers(to: &integers)
}

queue.async(group: group) {
    addingNumbers(to: &integers)
}

group.wait()
print(integers.count)

