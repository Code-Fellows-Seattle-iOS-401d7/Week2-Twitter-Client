//: Playground - noun: a place where people can play

import UIKit


//Adding a dependency for an operation before another operation, makes the execution serial.

var op1 = Operation()
var op2 = Operation()
op2.addDependency(op1)

var serialQueue = OperationQueue()

serialQueue.addOperations([op1, op2], waitUntilFinished: false)



