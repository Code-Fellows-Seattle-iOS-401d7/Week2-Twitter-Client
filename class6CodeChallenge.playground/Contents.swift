
import UIKit


//#CodeChallenge

// write a function that reverse an array

let arr = ["reverse", "this", "array", "of", "strings"]
var newArr = [String]()

for string in arr {
    newArr.insert(string, at: 0)
    print(newArr)
}