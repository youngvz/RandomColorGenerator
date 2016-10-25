//
//  ViewController.swift
//  Week3 Class
//
//  Created by Viraj Shah on 10/24/16.
//  Copyright © 2016 PantherHackers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    /*
     
     Hey everyone! Welcome to Week 3 of the iOS Interest Group! Hope you are ready to code!
     In this example we will go over:
     
     - Swift 3 Syntax
     - Array & Dictionary declaration
     - Closures
     - Event driven programming (Event listeners and handlers)
     - Optionals
     - Casting
     - Auto Layout constraints
     
     
     **/
    
    //  Here are common data structures you should familiarize yourself with.
    
    // Array declaration
    let colors = ["Red", "Blue", "Green", "Yellow", "White", "Orange"]
    
    /**  Dictionary declaration (Hash table)
     
     A dictionary stores associations between keys of the same type and values of the same type in a collection with no defined ordering. Each value is associated with a unique key, which acts as an identifier for that value within the dictionary. Unlike items in an array, items in a dictionary do not have a specified order. You use a dictionary when you need to look up values based on their identifier, in much the same way that a real-world dictionary is used to look up the definition for a particular word.
     
     colorDictionary is a dictionary with the key value pair String for UIColor
     
     
     */
    var colorDictionary:[String: UIColor] = ["Red": .red, "Blue": .blue, "Green": .green, "Yellow": .yellow, "White": .white, "Orange": .orange]
    
    
    /*CLOSURES
     
     Closures what are they?
     
     Closures are self contained chunks of code that can be passed around and used in your code. Closures can capture and store references to any constants or variables from the context in which they are defined.
     
     
     Here we are instantiating a UIButton object named colorButton, we are declaring it with as a lazy var instead of let because we want the button to have a reference to itself.
     
     We will cover this further in future classes, just know you have to declare this code block with lazy var
     
     */
    
    lazy var colorButton: UIButton = {
        
        // Set button properties
        let button = UIButton()
        button.setTitle("Press Me", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.5
        button.backgroundColor = .white
        
        // In order for the compiler to know you are going to define the UIButton's constraints programatically you must set the button's translatesAutoresizingMaskIntoConstraints property to false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Here we are creating an event listener and defining the event that gets trigged when the button is touched
        // When this button is touched, the function handleButton will be called
        
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        
        return button
    }()
    
    /* OPTIONALS
     
     Swift also introduces optional types, which handle the absence of a value. Optionals say either “there is a value, and it equals x” or “there isn’t a value at all”. Using optionals is similar to using nil with pointers in Objective-C, but they work for any type, not just classes. Not only are optionals safer and more expressive than nil pointers in Objective-C, they are at the heart of many of Swift’s most powerful features.
     
     
     
     Swift is a type-safe language, which means the language helps you to be clear about the types of values your code can work with. If part of your code expects a String, type safety prevents you from passing it an Int by mistake. Likewise, type safety prevents you from accidentally passing an optional String to a piece of code that expects a nonoptional String. Type safety helps you catch and fix errors as early as possible in the development process.
     
     
     Here we are declaring an Optional Int called randomInt
     We use the var declaration because this value will mutate(change)
     Optionals are denoted by the ?
     
     */
    
    
    var randomInt: Int?
    
    
    func handleButton(){
        
        /** Here we are defining a value for randomInt
         We use the func arc4random_uniform(x) to get us a random integer from 0 to x
         
         To make sure we do not get an index out of bounds error, the limit of how x can
         be is defined by the number of colors in our colorsDictionary
         We can get that value by using the colorsDictionary.count
         
         CASTING
         
         In Swift, we can CAST objects to be a certain type. In this example, arc4random_uniform(x) only takes
         parameters which are of the type UInt32.
         
         colorDictionary.count returns an Int so we must cast it as a UInt32
         
         the method arc4random_uniform returns a UInt32 so we must cast it as an Int when we assign it to randomInt
         
         
         This may seem a bit excessive but it is to familiar yourself with Swift concepts
         
         */
        randomInt = Int(arc4random_uniform(UInt32(colorDictionary.count)))
        
        changeColorAndTitle()
        
    }
    
    func changeColorAndTitle(){
        
        // Set the background color of the view to be a random color
        // Here we are unwrapping the randomInt Optional with the !
        // Because we declared randomInt as an optional we must unwrap it
        view.backgroundColor = colorDictionary[colors[randomInt!]]
        
        
        // String interpolation
        // In Swift 3, we can append Strings inline by using \() to pass in a variable
        // In this case, we set the title of the Navigation Bar to be the Color of the Screen
        navigationItem.title = "The Color is \(colors[randomInt!])!"
    }
    
    
    // Main
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the default background color to red
        view.backgroundColor = .red
        
        setupViews()
        setupNavBar()
    }
    
    
    
    func setupNavBar(){
        
        // We set the title of the navigationbar to Press the Button and the background color to White
        navigationItem.title = "Press the Button"
        navigationController?.navigationBar.barTintColor = .white
    }
    
    
    func setupViews(){
        
        // Adds the UIButton colorButton to the view controller stack
        view.addSubview(colorButton)
        
        /* Auto Layout Constraints
         
         Auto Layout dynamically calculates the size and position of all the views in your view hierarchy, based on constraints placed on those views.
         
         Since the introduction of iOS 9, we can assign these autolayout constraints programatically by using the .constraint
         on an layout anchor
         
         Auto Layout Constraints dictate that you must assign an x, y, width, and height Anchor
         
         To understand the x and y anchors, think of the device as grid
         The origin (0,0) is the top leftmost corner
         
         **/
        
        // We are pinning the bottomAnchor of the colorButton flush to the bottomAnchor of the view
        colorButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        // We are pinnig the leftAnchor of the colorButton flush to the leftAnchor of the view
        colorButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        // These are the x and y anchors for the colorButton
        // No matter what device screensize the app is running on, the button will always be placed in the bottom left corner
        
        
        // Here we set the width of the button to span across the entire width of the view
        // No matter what device screensize the app is running on, the button will be pinned
        //to the button left corner and span across the width of the device
        colorButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        // Here we set the height of the colorbutton to be 50 Pixels High
        // This value will be 50 pixel high on all screen sizes and will not be relative to the device screen size
        colorButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
}

