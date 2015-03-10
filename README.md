# VSTextField
Dead simple drop-in subclass of UITextField with super easy number formatting.

## How to use it?
Just place the VSTextField.swift file into your project and replace your current UITextField with it. Then set:

```swift
textField.setFormatting(formattingPattern: "##-##-##", replacementString: "#")  // all # will be replaced by numbers
```

