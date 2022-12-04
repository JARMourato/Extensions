// Copyright © 2022 JARMourato All rights reserved.

import Foundation

/// A wrapper for a string KeyPath that is definend by a dot `.` separator
public struct KeyPath : Hashable {
    /// The components of the string KeyPath
    public let segments: [String.SubSequence]
    /// Whether the KeyPath has no components.
    public var isEmpty: Bool { return segments.isEmpty }

    /// Strips off the first segment and returns a pair consisting of the first segment and the remaining key path.
    /// Returns `nil` if the key path has no segments.
    public func headAndTail() -> (head: String, tail: KeyPath)? {
        guard !isEmpty else { return nil }
        var tail = segments
        let head = tail.removeFirst()
        return (String(head), KeyPath(segments: tail))
    }
    /// The first component of the KeyPath
    public func head() -> String? { return headAndTail()?.head }
    /// The KeyPath that results from removing the `head`
    public func tail() -> KeyPath? { return headAndTail()?.tail }

    public func hash(into hasher: inout Hasher) { return description.hash(into: &hasher) }
}

extension KeyPath {
    public init(_ string: String) {
        segments = string.split(separator: ".")
    }
}

extension KeyPath : ExpressibleByStringLiteral {
    public init(stringLiteral value: String) { self.init(value) }
    public init(unicodeScalarLiteral value: String) { self.init(value) }
    public init(extendedGraphemeClusterLiteral value: String) { self.init(value) }
}

extension KeyPath : CustomStringConvertible {
    public var description: String { return segments.joined(separator: ".") }
}

public func + (lhs: KeyPath, rhs: KeyPath) -> KeyPath {
    return KeyPath(lhs.description + "." + rhs.description)
}

extension Dictionary where Key == String, Value == Any {
    public subscript(keyPath keyPath: KeyPath) -> Any? {
        get {
            guard let (head, tail) = keyPath.headAndTail() else { return self } // The key path is empty
            let key = head
            if tail.isEmpty { return self[key] } // The end of the key path
            guard let nestedDictionary = self[key] as? [Key:Any] else { return nil }
            return nestedDictionary[keyPath: tail]
        }
        set {
            guard let (head, tail) = keyPath.headAndTail() else { preconditionFailure("Trying to assign to an empty key path.") }
            let key = head
            if tail.isEmpty { return self[key] = newValue } // The end of the key path
            let value = self[key] ?? [:]
            var nestedDictionary = value as? [Key:Any] ?? {
                print("Expected nested JSON object at key \"\(key)\", but found \(value). Value will be overwritten.")
                return [:]
            }()
            nestedDictionary[keyPath: tail] = newValue
            self[key] = nestedDictionary
        }
    }
}

