//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let emojiRanges = [
    0x1F601...0x1F64F,
    0x2702...0x27B0,
    0x1F680...0x1F6C0,
    0x1F600...0x1F636,
    0x1F681...0x1F6C5,
    0x1F30D...0x1F567
]

for range in emojiRanges {
    print("Range-----------")
    for i in range {
        var c = ""
        c.unicodeScalars.append(UnicodeScalar(i)!)
        print(c)
    }
}
