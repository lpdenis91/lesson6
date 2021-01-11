//
//  main.swift
//  l6_BurdinDenis
//
//  Created by u on 11.01.2021.
//

import Foundation

let even: (Int) -> Bool = { $0 % 2 == 0 }
let odd: (Int) -> Bool = { $0 % 2 != 0 }


protocol Idable {
    var id: Int { get set }
}

class Circle: Idable {
    var id: Int
    let radius: Double
    func calcPerimeter() -> Double {
        return 2 * Double.pi * radius
    }
    
    init(id: Int, radius: Double) {
        self.id = id
        self.radius = radius
    }
}

class Rectangle: Idable {
    var id: Int
    let sideLeft: Double
    let sideTop: Double
    func calcPerimet() -> Double {
        return 2 * (sideLeft + sideTop)
    }
    
    init(id: Int, sideLeft: Double, sideTop: Double) {
        self.id = id
        self.sideLeft = sideLeft
        self.sideTop = sideTop
    }
}

struct Queue<T: Idable> {
    var elements: [T] = []
    mutating func push(_ element: T) {
        elements.append(element)
    }
    mutating func pop() -> T {
        return elements.removeFirst()
    }
    
    subscript(index: Int) -> Int? {
        guard !elements.isEmpty else { return .none }
        
        if index >= 0 && index <= elements.count - 1 {
            return elements[index].id
        }
        return .none
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        var string: String = ""
        for element in elements {
            string += "\(element.id) "
        }
        return string
    }
}

extension Queue {
    func showId(evenOrOdd: (Int) -> Bool) -> [Int] {
        var checkedId: [Int] = []
        for element in elements {
            if evenOrOdd(element.id) {
                checkedId.append(element.id)
            }
        }
        return checkedId
    }
}

var queueCircle = Queue<Circle>()
var queueRectangle = Queue<Rectangle>()

queueCircle.push(Circle(id: 123, radius: 27))
queueCircle.push(Circle(id: 234, radius: 54))
queueCircle.push(Circle(id: 345, radius: 9))

print(queueCircle)

queueRectangle.push(Rectangle(id: 987, sideLeft: 12, sideTop: 5))
queueRectangle.push(Rectangle(id: 876, sideLeft: 2, sideTop: 25))
queueRectangle.push(Rectangle(id: 765, sideLeft: 42, sideTop: 29))

print(queueRectangle)

let resultEven = queueCircle.showId(evenOrOdd: even)
print(resultEven)

let resultOdd = queueRectangle.showId(evenOrOdd: odd)
print(resultOdd)

print(queueRectangle[2])
queueRectangle.pop()
print(queueRectangle[2])
