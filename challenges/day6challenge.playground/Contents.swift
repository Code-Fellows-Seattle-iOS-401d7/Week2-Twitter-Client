//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// Code Challenge: Write a function that reverses an array

var myArray = ["a", "b", "c", "d"]

func reverse(_ array: [Any]) -> [Any] {
    return array.reversed()
}

reverse(myArray)

reverse([1,2,3,4,5])
