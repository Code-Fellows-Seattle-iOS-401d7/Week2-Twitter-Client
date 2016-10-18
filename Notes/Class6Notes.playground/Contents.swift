import UIKit


                        ////// CLASS 6 \\\\\\
                        ///// 10/17/16  \\\\\

/*
 #NOTES:
 
 Xcode & Git
 
 * gitignore
    - hiding files that you don't want to track!
 
 * MVC
    - Model-View-Controller
    - separation of concerns in your code
    - makes easier to read, reuse, test, think about, discuss
        -> Model layer is the data of your app
            - captures behavior of the app(problem domain)
            - independent of interface
            - manages data, logic, rules
            ---> Sources
                - remote resource
                - preloaded with the app
                - the user
        -> View Layer is anything the user sees or interacts with
            - any output presented to the user(buttons, lablels, colors)
        -> Controller layer mediates between the two
            - accepts user interactions from view layer
    - keeps everything loosley coupled and organized
 
 * JSON (JavaScript Object Notation)
    - "what is seen spit out..."
    - open standard for human readable text to transmit data objects consisting of attribute-value pairs
        -> types that can be contained in JSON
            -- Number
            -- String
            -- Bool (0 or 1, true or false)
            -- Array
            -- Object (dictionary)
            -- null
    ** array of dictionaries or dictionary for root object **
        -> JSON Workflow
            -- event triggers request
            -- server recives request, processes and sends back
            -- client receives response, checks for errors and then serializes JSON "data payload" inot objects
            -- client parses through the objects and creates model objects
            -- client displays model objects to user
    -> JSON Options
        - JSONReadingMutableContainers
            - specifying objects will be array or dict
        - JSONReadingMutableLeaves
            - specify mutable strings
        - JSONReadingAllowFragments
            - specifies parses should allow top level objects are not array or dict
 
 * Bundles 
    - dirwectory with a standard hierarchical structure that holds code and resource for code
    - programming interfaces for accessing the contents of bundles in your code
    - "file system in your app sandbox"
        -> info.plist
            -- conifg info for app, relies on to know certain config info
        -> assets
    - NSBundle has a class instance called "main"
        - returns the bundle that contains the code and resources for running app
    - can access other bundles with Bundle(path:)
 
 * UITableView
    - presents data in a scrollable list of multiple rows that may be divided into sections
    - cannot scroll vertically/only one column
    - any number of rows/sections
    - subclass of UIView
    - can take any shape and size
    - rely on 2 delegate objects to work
        - delegate --> user interaction with the table view
            -- implemented as protocols
        - data source --> responsible for the supply the table view with data to show
        ** Required methods **
            -- numberOfRowsInSection
            -- cellForRowAt(indexPath)
    - cells are reused, so make sure to properly clear out the old data before shown again
        - can take place in cellForRowAt by giving its labels and views new data that overwrites the old data
    - 

 gitignore.io
    -> copy the text provided
    -> terminal
 
 */


