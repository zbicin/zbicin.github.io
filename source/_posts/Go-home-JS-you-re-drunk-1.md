---
title: 'Go home JS, you''re drunk'
date: 2015-10-17
tags: JavaScript
---

# Go home JS, you're drunk

What would be the result of the following code:

```javascript
var myArray = undefined; // intended to be an array, but happened to be undefined e.g. due to a missing function parameter
var isCondition = myArray && myArray.length > 0;
console.log(isCondition);
```

?

Boolean false? Apparently not. The `isCondition` would be equal to... `undefined`. What implications does it have? 

If we used the `isCondition` variable in code later on in an `if` statement like this:

```javascript
    if(isCondition) { /* ... */ }
```

the `isCondition` would eventually evaluate to `false` and everything's gonna work as expected. However, if we compared `isCondition` to `false`:

```javascript
    if(isCondition == false) { /* ... */ }
    // or even better
    if(isCondition === false) { /* ... */ }
```

the code inside the brackets would not be launched. The `isCondition` *would not be casted to a boolean value* and `undefined` is definately not equal to `false` so the whole expression becomes falsy. The same principle applies in case of `myArray` being equal to `null` by any chance. Suddenly the term _Ninja JS Developer_ got a brand new meaning.