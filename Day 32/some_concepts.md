We use the ```.scaleEffect()``` modifier to trigger the button every time it's tapped.

We can ask SwiftUI to create an implicit animation for our changes so that all the scaling happens smoothly by adding an animation() modifier to the button:
```
.animation(.default, value: animationAmount)
```
The above code means that perform the default animation whenever the value changes.

That asks SwiftUI to apply a default animation whenever the value of animationAmount changes, and we can see that tapping the button now causes it to scale up with an animation.

Personal note: add the animation modifier after writing the scaleEffect modifier.

If we attach more animating modifiers to the view then they will all change together.
For example, we could add a second new modifier to the button, ```.blur()``` , which lets us add a Gaussian blur with a special radius.
Note: Add this before the animation() modifier:
```
.blur(radius: (animationAmount - 1) * 3)
```

If we want to make the animation bouncy, we have option for that, by using spring modifier with the duration and bounce as input, where duration means how much seconds it is going to bounce,
and the bounce value should be between 0 to 1 where 0 is no bounciness and 1 is extremely bouncy
```
.animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
```

```.easeInOut()``` modifier basically provides animation that first start slow, pick up speed and slow down at the end

```
.animation(
    .easeInOut(duration: 1)    //1 second duration 
        .repeatCount(3, autoreverses: true),   //repeats three times, but be careful, if any times, it should match the state property at end.
    value: animationAmount
)
```

We can use these repeatForever() animations in combination with onAppear() to make animations that start immediately and continue animating for the life of the view.

```Button("Tap Me") {
    // animationAmount += 1
}
.padding(50)
.background(.red)
.foregroundStyle(.white)
.clipShape(.circle)
.overlay(
    Circle()
        .stroke(.red)
        .scaleEffect(animationAmount)
        .opacity(2 - animationAmount)
        .animation(
            .easeInOut(duration: 1)
                .repeatForever(autoreverses: false),
            value: animationAmount
        )
)
.onAppear {
    animationAmount = 2
}
```

The ```animation()``` modifier can be applied to any SwiftUI binding, which causes the value to animate between its current and new value.

Best explained with some working code to look at, so here’s a view with a VStack, a Stepper, and a Button:
```
struct ContentView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
            .easeInOut(duration: 1)
              .repeatCount(3, autoreverses: true)
            )

            Spacer()

            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
        }
    }
}
```

With this variant of the ```animation()``` modifier, we don’t need to specify which value we’re watching for changes – it’s literally attached to the value it should watch!

Now, for explicit animations, 
When that button is tapped, we’re going to make it spin around with a 3D effect. 
This requires another new modifier, ```rotation3DEffect()```,
Which can be given a rotation amount in degrees as well as an axis that determines how the view rotates. Think of this axis like a skewer through your view:

If we skewer the view through the X axis (horizontally) then it will be able to spin forwards and backwards.
If we skewer the view through the Y axis (vertically) then it will be able to spin left and right.
If we skewer the view through the Z axis (depth) then it will be able to rotate left and right.

Now the code for some 3DAnimations that I learnt:
```
struct ContentView: View {
    @State private var animationAmount = 0.0

    var body: some View { 
            Button("Tap Me") {
                withAnimation{
                  animationAmount += 360
                }
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}
```

We can also make that animation bouncy by, adding these modifiers
```
withAnimation(.spring(duration: 1, bounce: 0.5)) {
    animationAmount += 360
}
```
