Learning about closures from examples.

```
let driving = {
	print(“I’m driving a car”)
}
driving()
```

```
func signautograph(to name : string){
	print(“Signing my autograph to \(name), my #1 fan!)
}
signautograph(to : “Ram”)
```

```
let signautograph = {
	print(“signing my autograph to Ram , my #1 fan!”)
}
signautograph()
```

To accept parameters we use the following syntax which is different than accepting parameters from a function..
For example :- 
note that we use “in” commands to inform swiftui from where does our main program starts.

```
var visitingplace = { (destination : String) in
	print(“I’m going to visit \(destination) next month !”)
}
visitingplace(“Seoul”)
```

Also note that we don’t use parameters label when running closures, i.e. when passing values.

```
var click = { (button : Int) in
	if button >= 0 {
		print(“Clicking the button \(button)”)
	}else {
		print(“The button does not exist !”)
	}
}
click(7)
```

When writing code for closures, we don’t use external parameter for closures.

```
let rowboat = { (distance : Int) in 
	for _ in 1…distance{
		print(“I’m rowing 1 km.”)
	}
}
rowboat(5)
```


RETURNING VALUES IN A CLOSURE 

```
let driving = { (place : String) -> String in
	return (“I’m going to \(place) in my car.”)
}
let message = driving(“London”)
print(message)
```

```
var flydrone = { (haspermit : Bool) -> Bool in
	if haspermit {
		print(“Lets fly the drone here.”)
		return true
	}
	print(“thats against the laws !”)
	return false
 }
```

```
let measureSize = { (inches: Int) -> String in
	switch inches {
	case 0...26:
		return "XS"
	case 27...30:
		return "S"
	case 31...34:
		return "M"
	case 35...38:
		return "L"
	default:
		return "XL"
	}
}
measureSize(36)
```

```
let convertNumerals = { (numeral: String) -> String in
	switch numeral {
	case "I":
		return "1"
	case "II":
		return "2"
	case "III":
		return "3"
	default:
		return “Not capable yet.”
	}
}
print(convertNumerals("II"))
```

```
let resignation = { (name: String) in
	print("Dear \(name), I'm outta here!")
}
func printDocument(contents: () -> Void) {
	print("Connecting to printer...")
	print("Sending document...")
	contents()
}
printDocument(contents: resignation)
```

The above program’s not correct, printDocument() says its parameter must be a closure that accepts no parameters, but the closure it is given takes a string.


```
let travel = {
	print(“I’m driving the car”)
}
func trip( action : () -> void ) {
	print(“we’re arriving now”)
	action()
	print(“we’re at the destination”)
}
trip(action : travel)

//Now using trailing closures

func travel(action : () -> void){
	print(“we’re arriving now”)
	action()
	print(“we’re at the destination”)
}

//Because its last parameter is a closure, we can call travel() using trailing closure syntax like this:

travel() {
	print(“I’m driving the car”)
}

//In fact, because there aren’t any other parameters, we can eliminate the parentheses entirely:

travel {
    print("I'm driving in my car")
}
```

When using trailing closure syntax we should miss off the final parameter name.

```
func repeatAction(count: Int, action: () -> Void) {
	for _ in 0..<count {
		action()
	}
}
repeatAction(count: 5) {
	print("Hello, world!")
}
```

```
func goOnVacation(destination : String, _activities : () -> Void) {
	print(“Packing bags”)
	print(“Getting to \(destination)”)
	activities()
	print(“Going home.”)
}
goOnVacation(destination : “Mexico”) {
	print(“What a lovely weather”)
	print(“The regional food is delicious”)
}
```
