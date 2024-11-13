1.   For first challenge,
```
    Section("Total amount for check") {
                    Text(totalAmountForCheck, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .primary)
                }
```

2. For second challenge,
```
struct FlagImage: View {
    let country: String

    var body: some View {
        Image(country)
            .resizable()
            .scaledToFit()
            .clipShape(.capsule)
            .shadow(radius: 10)
    }
}
```

And for the code which shows flags, now write the following code in label section
```
ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                            questionsAsked(questionCounter)//flag was tapped
                        }label: {
                            FlagImage(country: countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 10)
                        }
              }
```

3. For the third challenge,
```
import SwiftUI

struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)     
            .foregroundColor(.blue) 
    }
}

extension View {
    func largeBlueTitle() -> some View {
        self.modifier(LargeBlueTitle())
    }
}
```

