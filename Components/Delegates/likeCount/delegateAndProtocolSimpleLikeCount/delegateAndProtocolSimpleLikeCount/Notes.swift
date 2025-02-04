//
//  Notes.swift
//  delegateAndProtocolSimpleLikeCount
//
//  Created by David Vasquez on 12/29/24.
//

import Foundation

//Protocol is the Interface
//Delegate is a design pattern it uses an interface


/*
// Delegate
class Counter {
    private var value: Int = 0 {
        didSet { print("Counter value: \(value)") }
    }

    func increment() {
        self.value += 1
    }
}

// Delegator
class Control {
    private var delegate: Counter

    init(delegate: Counter) {
        self.delegate = delegate
    }

    func buttonClicked() {
        self.delegate.increment()
    }
}

let counter = Counter()
let control = Control(delegate: counter)

control.buttonClicked()
// Counter value: 1
control.buttonClicked()
// Counter value: 2
*/

/*
 protocol Eatable {
     func eat()
 }
 
 class Human: Eatable {
     func eat() {
         print("Nom nom nom...")
     }
 }
 
 Imagine you’re the director of a movie. You can’t possibly handle every single task, right? You delegate! You tell the cameraperson to handle the shots, the sound engineer to manage the audio, and so on. In Swift, a delegate is like your trusted crew member, taking care of specific tasks or events on behalf of another class.
 
 
 //PROTOCOL
 protocol LaundryDelegate {
     func doLaundry()
 }
 
 
 class Person {
     var laundryDelegate: LaundryDelegate?
     
     func clothesAreDirty() {
         laundryDelegate?.doLaundry()
     }
 }
 
 
 class Robot: LaundryDelegate {
     func doLaundry() {
         print("Laundry done. Beep boop.")
     }
 }

 let john = Person()
 let robot = Robot()
 john.laundryDelegate = robot
 john.clothesAreDirty()  // Output: "Laundry done. Beep boop."
 
 
 
 */
