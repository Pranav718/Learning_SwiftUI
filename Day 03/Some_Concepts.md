# Learning SwiftUI day 3


Swift has a rarely used operator called the ternary operator. It works with three values at once, which is where its name comes from: it checks a condition specified in the first value, and if it’s true returns the second value, but if it’s false returns the third value.
The ternary operator is a condition plus true or false blocks all in one, split up by a question mark and a colon, all of which which makes it rather hard to read. Here’s an example:

```
let firstCard = 11
let secondCard = 10
print(firstCard == secondCard ? "Cards are the same" : "Cards are different")
```

It can also be written normally-

```
if firstCard == secondCard{
	print(“Cards are same”)
}else{
	print(“Cards are different”)
}
```


Switch-Case statements can be used instead of if and else statements:

```

let weather=“sunny”
switch weather{
case “rain”:
	print(“bring umbrella”)
case “sunny”:
	print(“take sunscreen”)
case “snowy”:
	print(“enjoy.”)
default:
	print(“enjoy your day”)
}
```
Use fallthrough statement after last case so that swift can go across each cases i.e. if we dont use fallthrough statement then if 2 or more case statements are true,it'll only print the first time when case statement was true.
