For making an optional add a question mark after it for example , 
```
var age : int? =  nil
```

Optional strings might contain a string like “Hello” or they might be nil – nothing at all.

Consider this optional string:
```
var name: String? = nil
```

What happens if we use name.count? A real string has a count property that stores how many letters it has, but this is nil – it’s empty memory, not a string, so it doesn’t have a count.
Because of this, trying to read name.count is unsafe and Swift won’t allow it. Instead, we must look inside the optional and see what’s there – a process known as unwrapping.

A common way of unwrapping optionals is with if let syntax, which unwraps with a condition. If there was a value inside the optional then you can use it, but if there wasn’t the condition fails.

For example:
```
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}
```

If name holds a string, it will be put inside unwrapped as a regular String and we can read its count property inside the condition. Alternatively, if name is empty, the else code will be run.


An alternative to if let is guard let, which also unwraps optionals. guard let will unwrap an optional for us, but if it finds nil inside it expects us to exit the function, loop, or condition we used it in.
However, the major difference between if let and guard let is that our unwrapped optional remains usable after the guard code.


If we have a string that contains a number, we can convert it to an Int like this:
```
let str = "5"
let num = Int(str)
```

That makes num an optional Int because we might have tried to convert a string like “Fish” rather than “5”.

Even though Swift isn’t sure the conversion will work, we can see the code is safe so we can force unwrap the result by writing ! after Int(str), like this:
```
let num = Int(str)!
```

Swift will immediately unwrap the optional and make num a regular Int rather than an Int?(optional int). But if we’re wrong – if str was something that couldn’t be converted to an integer – our code will crash.
As a result, we should force unwrap only when we’re sure it’s safe – there’s a reason it’s often called the crash operator.


Swift provides us with a shortcut when using optionals: if we want to access something like a.b.c and b is optional, you can write a question mark after it to enable optional chaining: a.b?.c.
When that code is run, Swift will check whether b has a value, and if it’s nil the rest of the line will be ignored – Swift will return nil immediately. But if it has a value, it will be unwrapped and execution will continue.

To try this out, here’s an array of names:
```
let names = ["John", "Paul", "George", "Ringo"]
```

We’re going to use the first property of that array, which will return the first name if there is one or nil if the array is empty. We can then call uppercased() on the result to make it an uppercase string:
```
let beatle = names.first?.uppercased()
```

That question mark is optional chaining – if first returns nil then Swift won’t try to uppercase it, and will set beatle to nil immediately.

```
enum passwordError : Error {
	case obvious
}

func checkpassword(_ pass : String) throws -> Bool {
	if pass == “password”{
		throw passwordError.obvious
	}
	return true
}
```

There are two alternatives to try, both of which will make more sense now that we understand optionals and force unwrapping.

The first is try?, and changes throwing functions into functions that return an optional. If the function throws an error we’ll be sent nil as the result, otherwise we’ll get the return value wrapped as an optional.

Using try? we can run checkPassword() like this:
```
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}
```

The other alternative is try!, which we can use when we know for sure that the function will not fail. If the function does throw an error, our code will crash.

Using try! we can rewrite the code to this:
```
try! checkPassword("sekrit")
print("OK!")
```

```
struct Personid {
	var id : String
	
	init? (id : String){
		if id.count == 9{
			self.id = id
		}else{
			return nil
		}
	}
}
```

```
class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}
```

We can create a couple of fish and a couple of dogs, and put them into an array, like this:
```
let pets = [Fish(), Dog(), Fish(), Dog()]
```

Swift can see both Fish and Dog inherit from the Animal class, so it uses type inference to make pets an array of Animal.

If we want to loop over the pets array and ask all the dogs to bark, we need to perform a typecast: Swift will check to see whether each pet is a Dog object, and if it is we can then call makeNoise().

This uses a new keyword called as?, which returns an optional: it will be nil if the typecast failed, or a converted type otherwise.
Here’s how we write the loop in Swift:
```
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}
```

```
class Animal { }
class Fish : Animal { }
class Dog : Animal { 
	func makeNoise() {
		print(“woof woof”)
	}
}
let pets = [Fish(),Dog(),Fish(),Dog()]
for pet in pets {
	if let dog = pet as? Dog{
		dog.makeNoise()
	}
}
```





