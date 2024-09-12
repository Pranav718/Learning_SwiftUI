Some more struct concepts, init() and some examples!

```
struct user{
	var name : String
	init() {
		name = “anonymous”}
		print(“creating the username. . .”)
	}
}
```

We can see this if we create a User struct that has one property:
```
struct User {
    var username: String
}
```

When we create one of those structs, we must provide a username:
```
var user = User(username: "twostraws")
```

We can provide our own initializer to replace the default one. For example, we might want to create all new users as “Anonymous” and print a message, like this:

```
struct User {
    var username: String

    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}
```

We don’t write func before initializers, but we do need to make sure all properties have a value before the initializer ends.

```
Now our initializer accepts no parameters, we need to create the struct like this:
var user = User()
user.username = "Pranav718"
```

Inside methods we get a special constant called self, which points to whatever instance of the struct is currently being used. This self value is particularly useful when we create initializers that have the same parameter names as our property.
For example, if we create a Person struct with a name property, then tried to write an initializer that accepted a name parameter, self helps us distinguish between the property and the parameter – self.name refers to the property, whereas name refers to the parameter.
Here’s that in code:

```
struct Person {
    var name: String

    init(name: String) {
        print("\(name) was born!")
        self.name = name   // self.name refers to the property, whereas name refers to the parameter(i.e of initializer).
    }
}
```

```
struct Parent {
	var numberOfKids: Int
	var tirednessPercent: Int
	init (kids: Int) {
		self.numberOfKids = kids
	}
}
let james = Parent(kids: 2 , tirednesspercent : 74)
```

```
struct Language {
	var nameEnglish: String
	var nameLocal: String
	var speakerCount: Int
	init(english: String, local: String, speakerCount: Int) {
		self.nameEnglish = english
		self.nameLocal = local
		self.speakerCount = speakerCount
	}
}
let french = Language(english: "French", local: "français", speakerCount: 220_000_000)
```

Personal Note: During passing of the values, write initializer's parameter's name if the variables names are common, but we can write property as parameter too if the var name are not common as in the example above the above one.

```
struct NewsStory {
	static var breakingNewsCount = 0
	static var regularNewsCount = 0
	var headline: String
	init(headline: String, isBreaking: Bool) {
		self.headline = headline
		if isBreaking {
			NewsStory.breakingNewsCount += 1
		} else {
			NewsStory.regularNewsCount += 1
		}
	}
}
```
