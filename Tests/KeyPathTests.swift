// Copyright © 2022 JARMourato All rights reserved.

import XCTest
@testable import Extensions

final class KeyPathTests : XCTestCase {

    func testBasics() {
        let path1 = KeyPath("outer")
        assert(path1.description == "outer")
        let path2 = KeyPath("inner")
        assert((path1 + path2) == KeyPath("outer.inner"))
        assert(KeyPath("outer.inner").description == "outer.inner")
    }

    func testHeadAndTail() {
        let path = KeyPath("outer.inner")
        assert(path.head() == "outer")
        assert(path.tail() == "inner")
        assert(path.tail()?.tail() == "")
        assert(path.tail()?.tail()?.tail() == nil)
    }


    func testEmpty() {
        let empty = KeyPath("")
        let nonEmpty = KeyPath("outer.inner")
        assert(empty.isEmpty)
        assert(!nonEmpty.isEmpty)
    }

    func testDictionary() {
        var dic: [String:Any] = [
            "outer" : [
                "test" : "inner-result"
            ],
            "test" : "outer-result"
        ]
        assert(dic[keyPath: "test"] as? String == "outer-result")
        assert(dic[keyPath: "outer"] is [String:Any])
        assert(dic[keyPath: "nested.t"] == nil)
        assert(dic[keyPath: "outer.test"] as? String == "inner-result")
        dic[keyPath: "outer.set"] = "inner-set"
        assert(dic[keyPath: "outer.set"] as? String == "inner-set")
        assert((dic["outer"] as? [String:Any])?["set"] as? String == "inner-set")
        let emptyKeyPathResult = dic[keyPath: ""] as? [String:Any]
        assert(emptyKeyPathResult != nil)
        assert(emptyKeyPathResult?["test"] as? String == "outer-result")
        let newDic = [ "key" : "new" ]
        dic[keyPath: "nested.dic"] = newDic
        assert(dic[keyPath: "nested.dic.key"] as? String == "new")
    }
}
