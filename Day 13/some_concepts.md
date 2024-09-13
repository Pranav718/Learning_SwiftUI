On this day I switched from "100 Days Of Swift" to "100 Days Of SwiftUI" , as all the previous knowledge of swift are applicable here too, but on day 13th we would learn protocols and extensions again in the SwiftUI course.

As I already knew about protocols and extensions , I only practiced the examples so here are they
```
protocol Vehicle {
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car: Vehicle {
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }

    func openSunroof() {
        print("It's a nice day!")
    }
}
```

We might write some code to simulate someone commuting from their home to their office. We might create a small Car struct, then write a function like this:
```
func commute(distance: Int, using vehicle: Car) {
    // lots of code here
}
```

Of course, they might also commute by train, so we’d also write this:
```
func commute(distance: Int, using vehicle: Train) {
    // lots of code here
}
```

Or they might travel by bus:
```
func commute(distance: Int, using vehicle: Bus) {
    // lots of code here
}
```

Now using the new methods that were added to Car, 
```
func commute(distance: Int, using vehicle: Car) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car()
commute(distance: 100, using: car)
```

Now, the code will seem readable
```
protocol Vehicle {
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car: Vehicle {
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }

    func openSunroof() {
        print("It's a nice day!")
    }
}

func commute(distance: Int, using vehicle: Car) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car()
commute(distance: 100, using: car)
```

Swift knows that any type conforming to Vehicle must implement both the estimateTime() and travel() methods, and so it actually lets us use Vehicle as the type of our parameter rather than Car. We can rewrite the function to this:
```
func commute(distance: Int, using vehicle: Vehicle)
```

Now we’re saying this function can be called with any type of data, as long as that type conforms to the Vehicle protocol


We could write a method that accepts an array of vehicles and uses it to calculate estimates across a range of options:
```
protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}
```
That adds two properties:

A string called name, which must be readable. That might mean it’s a constant, but it might also be a computed property with a getter.
An integer called currentPassengers, which must be read-write. That might mean it’s a variable, but it might also be a computed property with a getter and setter.


```
extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
let quote = "There are many different paths from which we can reach the top of the mountain"
let trimmed = quote.trimmed()
```
