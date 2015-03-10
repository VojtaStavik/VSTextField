# VSTextField
Dead simple drop-in subclass of UITextField with super easy numbers formatting.

## How to use it?
Just place the VSTextField.swift file into your project and replace your current UITextField with it. Then set:

```swift
textField.replacementString = "*" // a string you want to be replaced by a number
textField.formattingPattern = "***ABC**-*-345-**" // all * will be replaced by a number
```