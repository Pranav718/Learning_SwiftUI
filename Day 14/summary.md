Optionals summary

1. Optionals let us represent the absence of data, which means we’re able to say “this integer has no value” – that’s different from a fixed number such as 0.
As a result, everything that isn’t optional definitely has a value inside, even if that’s just an empty string.

2. Unwrapping an optional is the process of looking inside a box to see what it contains: if there’s a value inside it’s sent back for use, otherwise there will be nil inside.

3. We can use if let to run some code if the optional has a value, or guard let to run some code if the optional doesn’t have a value – but with guard we must always exit the function afterwards.

4. The nil coalescing operator, ??, unwraps and returns an optional’s value, or uses a default value instead.

5. Optional chaining lets us read an optional inside another optional with a convenient syntax.

6. If a function might throw errors, we can convert it into an optional using try? – we’ll either get back the function’s return value, or nil if an error is thrown.
