//: Playground - noun: a place where people can play

import UIKit


//Adding a dependency for an operation before another operation, makes the execution serial.

var op1 = Operation()
var op2 = Operation()
op2.addDependency(op1)

var serialQueue = OperationQueue()

serialQueue.addOperations([op1, op2], waitUntilFinished: false)


let mySerialQ = OperationQueue()
//mySerialQ.maxConcurrentOperationCount = 1

//print( mySerialQ.operationCount)

mySerialQ.addOperation {

    if OperationQueue.current == OperationQueue.main {
        print("on Main Thread")
    } else {
        print("on background thread")
    }

    var url:NSURL = NSURL.fileURL(withPath:"https://www.petfinder.com/wp-content/uploads/2012/11/adopted-cat-281x211.jpg") as NSURL
    //var data:NSData = NSData.dataWithContentsOfURL(url, options: nil, error: nil)
    print("finished downloading")
    
}
if OperationQueue.current == OperationQueue.main {
    print("on Main Thread")
} else {
    print("on background thread")
}
print( "operation count", mySerialQ.operations.count)

mySerialQ.addOperation {
    var url:NSURL = NSURL.fileURL(withPath:"https://www.petfinder.com/wp-content/uploads/2012/11/adopted-cat-281x211.jpg") as NSURL
     print("OP2 finished downloading")

}
//print( mySerialQ.operationCount)

print( "operation count", mySerialQ.operations.count)



//var myImage =  UIImage(data: NSData(contentsOfURL: NSURL(string:"http://upload.wikimedia.org/wikipedia/en/4/43/Apple_Swift_Logo.png")))
//})
//print(self.user.profileImageUrlString)
let url:NSURL = NSURL(fileURLWithPath: "http:/pbs.twimg.com/profile_images/378800000242128405/210458af7f9fb725d89afa5721bcd46a_normal.jpeg") as NSURL
print(url.absoluteString)
let data:NSData = try! NSData(contentsOf: (url as NSURL) as URL)

