# Learning SwiftUI Day 12 Summary


1.Optionals let us represent the absence of a value in a clear and unambiguous way.

2.Swift won’t let us use optionals without unwrapping them, either using if let or using guard let.

3.We can force unwrap optionals with an exclamation mark, but if we try to force unwrap nil our code will crash.

4.Implicitly unwrapped optionals don’t have the safety checks of regular optionals.

5.We can use nil coalescing to unwrap an optional and provide a default value if there was nothing inside.

6.Optional chaining lets us write code to manipulate an optional, but if the optional turns out to be empty the code is ignored.

7.We can use try? to convert a throwing function into an optional return value, or try! to crash if an error is thrown.

8.If we need your initializer to fail when it’s given bad input, use init?() to make a failable initializer.
We can use typecasting to convert one type of object to another.

9.We can’t compare normal int and optional declared int
