Learning from function examples and some concepts



  func travel(action : (String) -> Void) {
		print(“We’re going to”)
		action(“London”)
	}

	travel { (place : String) in
		print(“\(place) in my car”)
	}

  func login(then action : (String) -> Void){
		print(“Authenticating. . .”)
		let username = “icecream”
		action(username)
	}
	login { (user : String) in
		print(“You’re welcome to the home screen, \(user) ! ” )
	}

  func fetchdata(then parse : (String) -> Void){
		print(“fetching data. . ..”)
		let data = “success!”
		parse(data)
	}
	fetchdata { (data : String) in
		print(“Data retrieved : \(data)”)
	}

  func makepizza(addtoppings : (Int) -> Void){
		print(“The dough is ready”)
		print(“The base is flat”)
		addtoppings(5)
	}
	makepizza { (toppingscount : Int) in
		let toppings = \[“onions”,”pepper”,”salami”]
		for i in 1…toppingscount{
			let required = toppings[i]
			print(“\(required) toppings added.”)
		}
	}

  func paybill(item : String , bill : (Int) -> Void){
		print(“The \(item) is added to your final bill”)
		bill(25)
	}
	paybill(item : “phone case”) { (paybill : Int) in
		print(“Damn $\(paybill) for this ?”)
	}

  func admissionreqs(docs : \[String] , copies : (Int) -> Void){
		print(“Okay everyone today we’re going to discuss the docs required for admission”)
		print(“Those docs are \(docs)” )
		copies(2)
	}
	admissionreqs(docs : \[“Aadhar card” , “class 12 mark sheet” , “class 10 mark sheet” ]) { (qty : int) in
		print(“\(qty) copies of them should be brought.”)}
	}


  func study(revisenotes : (String) -> Void){
		let notes = “Mitochondria is the powerhouse of a cell ”
		for i in 1…10{
			revisenotes(notes)
		}
	}
	study { (notes : string) in
		print(“I’m studying my notes : \(notes) ”)
	}



  func postontwitter(handles : (Int) -> Void) {
		print(“ While eating bread and butter on a flight I saw a fly that had butter on it, guess I should call it butterfly. . .”)
		let replies = 100
		postontwitter(replies)
	}
	postontwitter { (replies : Int) in
		print(“You got \(replies) on this post !”)
	}	


func getdirections(to place : String , then travel : ([String]) -> Void){
	let directions = \[
	“Go straight”,
	“Turn right”,
	“Go straight”
	“You have arrived at \(place)”
	]
	travel(directions)
}
getdirections { (directions : [String] in
	print(“I’m getting in my car.”)
	for direction in directions {
		print(direction)
	}
}


func getdirections {(to place : String , its navigation : ([String]) -> Void)
	let directions = \[
	“go straight”,
	“go right”,
	“go straight”,
	“You arrived at \(place)” 
	]
	navigation(directions)
}
getdirections(to : “London”) { (directions : \[String] ) in
	print(“I’m getting my car”)
	for direction in directions {
		print(direction)
	}
}

func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}
We can call travel() using something like this:

travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

However, Swift knows the parameter to that closure must be a string, so we can remove it:

travel { place -> String in
    return "I'm going to \(place) in my car"
}

It also knows the closure must return a string, so we can remove that:

travel { place in
    return "I'm going to \(place) in my car"
}
As the closure only has one line of code that must be the one that returns the value, so Swift lets us remove the return keyword too:
travel { place in
    "I'm going to \(place) in my car"
}
Swift has a shorthand syntax that lets you go even shorter. Rather than writing place in we can let Swift provide automatic names for the closure’s parameters. These are named with a dollar sign, then a number counting from 0.
travel {
    "I'm going to \($0) in my car"
}

- [x] func encrypt(password: String, using algorithm: (String) -> String) {
		print("Encrypting password...")
		let result = algorithm(password)
		print("The result is \(result)")
	}
	encrypt(password : t4ylor") { (password: String) in
		print("Using top secret encryption!")
		return "SECRET" + password + "SECRET"
	}


func encrypt( password : String , using algorithm : (String) -> String) { 
	print(“Encrypting password. . .”)
	let result = algorithm(password)
	print(“The result is \(result) ” )
}
encrypt( password : “Dogelikesicecream”) { (kuchv : String) in 
	print(“THE ENCRYPTED PASSWORD IS . . .”)
	return “SECURE” + kuchv + “SECURE”
}


func goshopping(for item : String , decisionhandler : (String) -> Bool ) {
	if decisionhandler(item) == true {
		print(“We’re gonna buy this \(item)”) 
	}
	else {
		print(“We’re getting this  next week for sure.”) 
	}
}
goshopping(for : “Shoes”) { (item : String) in 
	if item == “Shoes” {
		return false
	}
	else {
		return true
	}
}

func increaseBankBalance(start: Double, interestCalculator: () -> Double) {
	print("Your current balance is \(start).")
	let interestRate = interestCalculator()
	let withInterest = start * interestRate
	print("You now have \(withInterest).")
}
increaseBankBalance(start: 200.0) {
	return 1.01
}

- [x] func authenticate(algorithm: (String, String) -> Bool) {
	  print("Authenticating user")
	  let username = "twostraws"
	  let password = "fr0sties"
	  let result = algorithm(username, password)
	  if result {
		  print("You're in!")
	  } else {
		  print("Try again.")
	  }
      }
     authenticate { (result : String,String) in
     	if “$0” == “Pranav”{
      		return false
	}
	else {
		return true
	}



- [x] func createValidator() -> (String) -> Bool {
		return {
			if $0 == "twostraws" {
				return true
			} else {
				return false
			}
		}
	}
	let validator = createValidator()
	print(validator("twostraws"))


- [x] func makeRecorder(media: String) -> () -> String {
		switch media {
		case "podcast":
			return {
				return "I'm recording a podcast"
			}
		default:
			return {
				return "I'm recording a video"
			}
		}
	}
	let recorder = makeRecorder(media: "podcast")
	print(recorder())

- [ ] func createAgeCheck(strict: Bool) -> (Int) -> Bool {
		if strict {
			return {
				if $0 <= 21 {
					return true
				} else {
					return false
				}
			}
		} else {
			return {
				if $0 <= 18 {
					return true
				} else {
					return false
				}
			}
		}
	}
	let ageCheck = createAgeCheck(strict: true)
	let result = ageCheck(20)
	print(result)


func makeGreeting(language: String) -> (String) -> Void {
	if language == "French" {
		return {
			print("Bonjour, \($0)!")
		}
	} else {
		return {
			print("Hello, \($0)!")
		}
	}
}
let greeting = makeGreeting(language: "English")
greeting("Paul")

func createDoubler() -> (Int) -> Int {
	return {
		return $0 * 2
	}
}
let doubler = createDoubler()
print(doubler(2))

Return n  print returns nothing ie (void)
