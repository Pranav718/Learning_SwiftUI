Difference between classes and structs

The first difference between classes and structs is that classes never come with a memberwise initializer. This means if we have properties in our class, we must always create our own initializer.
For example:
```
class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
```

Creating instances of that class looks just the same as if it were a struct:
```
let poppy = Dog(name: "Poppy", breed: "Poodle")     
```

```
class Dog {
	func makenoise(){
		print(“woof!!”)
	}
}

class Poodle : Dog {
	override func makenoise() {
		print(“yip!”)
	}
}

let poppy = Poodle()
poppy.makenoise()
```

Although class inheritance is very useful – and in fact large parts of Apple’s platforms requires us to use it – sometimes we want to disallow other developers from building their own class based on ours.

Swift gives us a final keyword just for this purpose: when we declare a class as being final, no other class can inherit from it. This means they can’t override our methods in order to change our behavior – they need to use our class the way it was written.

To make a class final just put the final keyword before it, like this:
```
final class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
```

The third difference between classes and structs is how they are copied. When we copy a struct, both the original and the copy are different things – changing one won’t change the other. When we copy a class, both the original and the copy point to the same thing, so changing one does change the other.

The fourth difference between classes and structs is that classes can have deinitializers – code that gets run when an instance of a class is destroyed.

The final difference between classes and structs is the way they deal with constants. If we have a constant struct with a variable property, that property can’t be changed because the struct itself is constant.
However, if we have a constant class with a variable property, that property can be changed. Because of this, classes don’t need the mutating keyword with methods that change properties; that’s only needed with structs.
This difference means we can change any variable property on a class even when the class is created as a constant – this is perfectly valid code:

```
class Singer {
    var name = "Post Malone"
}

let post = Singer()
post.name = "The Weeknd"
print(post.name)
```

```
class bicycle {
	var name : string 
	var color : string 
	init (name : String , color : String ){
		   self.name = name
		   self.color = color
  }
}

class bicyclemodel : bicycle {
	var bicyclebrand : String
	init ( name : String , color : String , bicyclebrand : String ) {
		   self.bicyclebrand = bicyclebrand
		   super.init(name : name , color : color)
	}
}
```
