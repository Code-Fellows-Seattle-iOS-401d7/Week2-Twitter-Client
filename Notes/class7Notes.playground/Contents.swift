
import UIKit


                        ////// CLASS 7 \\\\\\
                        ///// 10/18/16  \\\\\



/*
 #NOTES:
 
 
 *** Closures ***
 
 --> self-contained blcoks of functionality that can be passed around in your code(does not necessarily have aname attached to it)
 
 - used in a significant portion of Apple's API's
 - functions are a special case of closure(named closure that perform a specific task)
    - developer uses name of function to call the function
 - fucntions type is a functions signature
 - since a func has a type, can store it in a variable
    - allows us to pass funcs in as parameters to other funcs, and also return funcs
 - every func/method has a type
 
 --> Closure Forms
    * "capturing for later", "not firing off yet"
    - Global Funcs
        -> no capturing
    - Nested Funcs
    - Closure Expression
        -> capture local variables/properties accessed inside itself
 
 * features *
    - shorthand
        -> use $ to refer to the parameters not by name but by order($0 is the first and $1 would be the second, etc.)
    - trailing
        -> if last parameter of a func, write the closure after the func call
    - Implicit Return Values
        -> if only one line of code, will try to return that result of the one statement(has a return value)
 
 
 *** Callbacks ***
 
    --> piece of executable code that is passed as an argument to tother code, which is expected to call back(execute the code) the argument at a specific time
 
 - asynchronous callback
    -> callback that happens at a later time(Social framework)
 
 
 
 
 
 
 
 */








/*
 #NOTES:
 
 
 *** Accounts Framework ***
 
    --> provide acces to user accounts stored in the accounts database
 
 - facebook and twitter
 - do not need to be responsible for storing account logins yourself(receive "token" to interact with social networks, no local copy)
 
 -> Workflow
    -- get reference to account store by instantiating an instance of ACAccountStore
    -- get refereence to correct account type by calling accountType(withAccountTypeIdenitifier:) on account store
    -- call requestAccessToAccounts(withType:, options:, completion:) on account store
    -- check if access was granted with
 
 *** Social Framework ***
 
    --> 
 
 - focuses on two aspects
    -> requests
    -> composing(uplaoding)
 
 -- Workflow
    - make request with Social Framework with SLRequest
        -> easy way to config and perform HTTP request
    - SLRequest..
 
 
 *** HTTP Response Codes ***
 
    --> status of HTTP requests
 
 - 200 -- OK(standard response)
 
 - 2## - Most API services only use 200, basically means it worked
 
 - 4## - clients fault(our app)
    -- wrong url, bad authentication, asking for something nto there
 
 - 5## - server error(not our fault)
 
 *** OperationQueue ***
 
    --> "multipe things happening at the same time"
 
 * threads *
    -- lightwieght way to implement multiple paths of execution inside of an app
    -- each program can have multiple threads of execution
    -- perform task (almost) simultaneuosly
    -- 2 main benefits:
        -> improved perceived/real-time responsiveness of your app
 - each thread needs to coordiante action with other threads (race condition)
    -- two objects trying to mutate same things in memory
 - ALL UI ON MAIN THREAD!!!
 
        ** OpQ **
    --> API designed to abstract away adding ops to different threads
    --> added to opq so they can be executed
    --> ctreate default init on opq
    --> add to specific queue
 
 * Queues are much safer to work with than threads(built-in)
 * abstraction layer built on top of threads(use threads under the hood)
 *** serial queue uses only one thread(one op at a time), concurrent queues may use multiple threads
 
 -  main queue is striclty a serial queue
 - by default, an OperationQueue you create is set to be concurrent
 - can change by chainging its maxConcurrentOperationCount value(setting to 1 makes a serial queue)
 
 
 */






