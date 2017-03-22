//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//Using playgrounds, and OperationQueue: Demonstrate creating a serial queue.

// A serial queue is created using:

let serialQueue = OperationQueue.main


//from lecture - create a different serial queue instead of using main.

let mySerialQueue = OperationQueue()
mySerialQueue.maxConcurrentOperationCount = 1

mySerialQueue.addOperation {
    //insert code here
}



