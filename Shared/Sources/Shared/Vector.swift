//
//  Vector.swift
//
//
//  Created by Maarten Engels on 06/07/2024.
//

import Foundation

public struct Vector {
    public var x: Int
    public var y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    // MARK: computed properties to quickly get common values
    public static var zero: Vector {
        Vector(x: 0, y: 0)
    }

    public static var left: Vector {
        Vector(x: -1, y: 0)
    }

    public static var right: Vector {
        Vector(x: 1, y: 0)
    }

    public static var up: Vector {
        Vector(x: 0, y: 1)
    }

    public static var down: Vector {
        Vector(x: 0, y: -1)
    }

    public static var one: Vector {
        Vector(x: 1, y: 1)
    }

    // MARK: vector arithmatic
    public static func +(lhs: Vector, rhs: Vector) -> Vector {
        Vector(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    public static func -(lhs: Vector, rhs: Vector) -> Vector {
        Vector(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    public static func *(v: Vector, scalar: Int) -> Vector {
        Vector(x: v.x * scalar, y: v.y * scalar)
    }

    public static func /(v: Vector, scalar: Int) -> Vector {
        Vector(x: v.x / scalar, y: v.y / scalar)
    }

    public static func distance(_ v1: Vector, _ v2: Vector) -> Double {
        let vector = v1 - v2
        return vector.length
    }

    public static func += (lhs: inout Vector, rhs: Vector) {
        lhs = lhs + rhs
    }

    public static func -= (lhs: inout Vector, rhs: Vector) {
        lhs = lhs - rhs
    }

    public static func *= (v: inout Vector, scalar: Int) {
        v = v * scalar
    }

    public var length: Double {
        sqrt(Double(self.x * self.x + self.y * self.y))
    }

    public static func dotNormalized(_ lhs: Vector, rhs: Vector) -> Double {
        let lhsLength = lhs.length
        let rhsLength = rhs.length
        let xDotPart = (Double(lhs.x) / lhsLength) * (Double(rhs.x) / rhsLength)
        let yDotPart = (Double(lhs.y) / lhsLength) * (Double(rhs.y) / rhsLength)
        return xDotPart + yDotPart
    }
}

extension Vector: Hashable {}

extension Vector {
    public var neighbours: [Vector] {
        [.left, .right, .up, .down]
            .map { self + $0 }
    }
}