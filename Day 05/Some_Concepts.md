All parameters passed into a Swift function are constants, so you can’t change them. If you want, you can pass in one or more parameters as inout, which means they can be changed inside your function, and those changes reflect in the original value outside the function.
For example, if you want to double a number in place – i.e., change the value directly rather than returning a new one – you might write a function like this:

``func doubleInPlace(number: inout Int) {
    number *= 2
}``

To use that, you first need to make a variable integer – you can’t use constant integers with inout, because they might be changed. You also need to pass the parameter to doubleInPlace using an ampersand, &, before its name, which is an explicit recognition that you’re aware it is being used as inout.
In code, you’d write this :

``var myNum = 10 
doubleInPlace(number: &myNum)``

Example 2:

``func multbysix(number : inout Int){
	number = number * 6	
}
var myNum = 23
multbysix(number : &myNum)``

Different names for parameters can be written in two words only i.e.

``func justanexample(outername innername : Int){
	//we'll use the inner name given to parameter during defining the function
	print(“passing an argument using the inner name inside the func  : \(andarwala))
}
justanexample(outername : 25) //passing an argument using the outer name outside the func ``
