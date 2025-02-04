import UIKit

var greeting = "Hello, playground"

print(greeting)

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
