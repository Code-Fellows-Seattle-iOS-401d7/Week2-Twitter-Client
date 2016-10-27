//: Playground - noun: a place where people can play

import UIKit

func reverseArray<T>(_ arr: [T]) -> [T]{

    var reversed = [T]()

    for ii in stride(from: arr.count-1, through: 0, by : -1) {
        reversed.append(arr[ii])
    }

//    reversed = arr.enumerated().map({ (index, element) in
//        return arr[arr.count - (index + 1)]
//    })


    return reversed

}

var foo = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"]

foo != foo.reversed()
reverseArray( foo ) == foo.reversed()


