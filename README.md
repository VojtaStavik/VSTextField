# VSTextField
Dead simple drop-in subclass of UITextField with super easy number formatting.

#### Example usage for a real time SSN formatting:

![Example with SSN formatting](http://vojtastavik.com//images/2015-03-29/vstextfield-example1.gif)

## How to use it?
Just place the VSTextField.swift file into your project and replace your current UITextField with it. Then set:

```swift
textField.setFormatting(formattingPattern: "##-##-##", replacementCharacter: "#")  
// all # will be replaced by numbers
```

