//: Playground - noun: a place where people can play

import UIKit

func itemsToFit(inWidth: Int, inHeight: Int, withMargin: Int, withSize: Int) -> Int {
    let rows = (inHeight - withMargin) / withSize
    let columns = (inWidth - withMargin * 2) / withSize
    print("Size \(withSize) = Rows \(rows) Columns \(columns) > \(columns * rows) items max")
    return columns * rows
}

let minSize = 50
let maxSize = 220
let maxWidth = 686
let maxHeight = 514
let margin = 8

//
for i in minSize...maxSize {
    itemsToFit(inWidth: maxWidth, inHeight: maxHeight, withMargin: margin, withSize: i)
}
