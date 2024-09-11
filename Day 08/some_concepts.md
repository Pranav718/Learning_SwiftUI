Structs

```
struct sport {
	var name : String
	var isolympicsport : Bool
	
	var olympicstatus : String {
		if olympicsport{
			return “ \(name) is an olympic sport “
		}else {
			return “\(name) is not an olympic sport “
		}
	}
}
let chessboxing = Sport(name : “Chessboxing” , isolympicsport : false )
print(chessboxing.olympicstatus)
```

```
struct Wine {
	var age: Int
	var isVintage: Bool
	var price: Int {
		if isVintage {
			return age + 20
		} else {
			return age + 5
		}
	}
}
let malbec = Wine(age: 2, isVintage: true)
print(malbec.price)
```

```
struct school {
	var age : Int
	var class : String
	var attendance : Bool
	var marks : Int
	var attendancedays : Int
	var bonus {
		if attendancedays >= 75 {
			return marks + 5
		 }
		else {
			return marks
		}
	}
}
let student = school(age : 17, class : “class 12”, attendance : true , marks : 94 , attendancedays : 77)
print(student.bonus)
```

We can’t use let modifier inside a struct.

Property observers let us run code before or after any property changes. To demonstrate this, we’ll write a Progress struct that tracks a task and a completion percentage:
```
struct Progress {
    var task: String
    var amount: Int
}
```
We can now create an instance of that struct and adjust its progress over time:
```
var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100
```
What we want to happen is for Swift to print a message every time amount changes, and we can use a didSet property observer for that. This will run some code every time amount changes:
```
struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}
```

We can also use willSet to take action before a property changes, but that is rarely used.

```
struct city {
    var population : Int
    func collecttaxes() -> Int {
           return population * 1000
    }
  }
  let london = city(population : 10000000)
  london.collecttaxes()
```

If a struct has a variable property but the instance of the struct was created as a constant(as in the above example), that property can’t be changed – the struct is constant, so all its properties are also constant regardless of how they were created.

The problem is that when we create the struct Swift has no idea whether we will use it with constants or variables, so by default it takes the safe approach: Swift won’t let you write methods that change properties unless you specifically request it.

When you want to change a property inside a method, you need to mark it using the mutating keyword, like this:
```
struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}
```

Because it changes the property, Swift will only allow that method to be called on Person instances that are variables:
```
var person = Person(name: "Ed")
person.makeAnonymous()
```

We’ve used lots of strings so far, and it turns out they are structs – they have their own methods and properties we can use to query and manipulate the string.

First, let’s create a test string:
```
let string = "Do or do not, there is no try."
```

We can read the number of characters in a string using its count property:
```
print(string.count)
```

They have a hasPrefix() method that returns true if the string starts with specific letters:
```
print(string.hasPrefix("Do"))
```

We can uppercase a string by calling its uppercased() method:
```
print(string.uppercased())
```

And we can even have Swift sort the letters of the string into an array:
```
print(string.sorted())
```

Strings have lots more properties and methods – try typing string. to bring up Xcode’s code completion options.


Arrays are also structs, which means they too have their own methods and properties we can use to query and manipulate the array.

Here’s a simple array to get us started:
```
var toys = \["Woody"]
```

We can read the number of items in an array using its count property:
```
print(toys.count)
```

If we want to add a new item,we use the append() method like this:
```
toys.append("Buzz")
```

We can locate any item inside an array using its firstIndex() method, like this:
```
toys.firstIndex(of: "Buzz")
//That will return 1 because arrays count from 0.
```

Just like with strings, we can have Swift sort the items of the array alphabetically:
```
print(toys.sorted())
```

Finally, if we want to remove an item, we use the remove() method like this:
```
toys.remove(at: 0)
```

Arrays have lots more properties and methods – try typing toys. to bring up Xcode’s code completion options.
