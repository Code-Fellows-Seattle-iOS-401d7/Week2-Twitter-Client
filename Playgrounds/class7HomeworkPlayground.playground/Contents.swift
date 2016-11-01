
import UIKit

var queue: DispatchQueue = DispatchQueue(label: "main")
print(queue)

let main = queue.activate()
print(main)



