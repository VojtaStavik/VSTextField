//
//  VSTextField.swift
//
//  Created by Vojta Stavik on 09/03/15.
//  Copyright (c) 2015 www.STRV.com All rights reserved.
//

import UIKit

enum TextFieldFormatting {
    
    case SocialSecurityNumber
    case Custom
    case Default
}


class VSTextField: UITextField {

    /**
    Set a formatting pattern for a number and define a replacement string. For example: If formattingPattern would be "##-##-AB-##" and
    replacement string would be "#" and user input would be "123456", final string would look like "12-34-AB-56"
    */
    func setFormatting(formattingPattern: String, replacementChar: Character) {
        
        self.formattingPattern = formattingPattern
        self.replacementChar = replacementChar
    }
    
    
    /**
    A character which will be replaced in formattingPattern by a number
    */
    var replacementChar: Character = "*"
    
    
    /**
    Max lenght of input string. You don't have to set this if you set formattingPattern.
    If 0 -> no limit.
    */
    var maxLenght = 0
    
    
    /**
    Type of predefined text formatting. You don't have to set this. (It's more a future feature)
    */
    var formatting : TextFieldFormatting = .Default {
        
        didSet {
            
            if formatting == .SocialSecurityNumber {
                
                self.formattingPattern = "***-**–****"
                self.replacementChar = "*"
            }
            
            else {
                
                self.maxLenght = 0
            }
        }
    }
    
    
    /**
    String with formatting pattern for the text field.
    */
    var formattingPattern: String = "" {
        
        didSet {
            
            self.maxLenght = count(formattingPattern)
            self.formatting = .Custom
        }
    }

    
    /**
    Text without formatting characters (read-only)
    */
    var textWithoutFormatting: String? {
        
        if let text = self.text {
            
            return VSTextField.makeOnlyDigitsString(text)
        }
        
        return nil
    }
    
    
    override var text: String! {
        
        set {
            
            super.text = newValue
            textDidChange() // format string properly even when it's set programatically
        }
        
        get { return super.text }
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        registerForNotifications()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        registerForNotifications()
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

    // MARK: - class methods
    
    class func makeOnlyDigitsString(string: String) -> String {
        
        return join("", string.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet))
    }
    
    
    
    // MARK: - internal
    
    private func numberOfDigitsInFormattingString(string: String) -> Int {

        var number: Int = 0
        
        for i in 0...max(0, count(string) - 1) {
            
            let range = Range<String.Index>(start: advance(string.startIndex, i), end: advance(string.startIndex, i + 1 ))
            
            if string.substringWithRange(range) == String(replacementChar) {
                
                number++
            }
        }
        
        return number
    }


    private func registerForNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: "UITextFieldTextDidChangeNotification", object: self)
    }
    
    
    func textDidChange() {
        
        if formatting == .Default {
            
            return;
        }
        
        
        if let textFieldString = super.text where formattingPattern != "" {
            
            let tempString = VSTextField.makeOnlyDigitsString(textFieldString)
            
            var finalText = ""
            var stop = false
            
            var formatterIndex = formattingPattern.startIndex
            var tempIndex = tempString.startIndex
            
            while !stop {
                
                let formattingPatternRange = Range(start: formatterIndex, end: advance(formatterIndex, 1) )
                
                if formattingPattern.substringWithRange(formattingPatternRange) != String(replacementChar) {
                    
                    finalText = finalText.stringByAppendingString(formattingPattern.substringWithRange(formattingPatternRange))
                }
                
                else if count(tempString) > 0 {
                    
                    let pureStringRange = Range(start: tempIndex, end: advance(tempIndex, 1))
                    
                    finalText = finalText.stringByAppendingString(tempString.substringWithRange(pureStringRange))
                    tempIndex++
                }
                
                formatterIndex++
                
                if formatterIndex >= formattingPattern.endIndex || tempIndex >= tempString.endIndex {

                    stop = true
                }
            }
            
            super.text = finalText
        }
        
        
        if maxLenght > 0 {
            
            if let text = self.text {
            
                if count(text) > maxLenght {
                    
                    self.text = self.text.substringToIndex(advance(self.text.startIndex, maxLenght))
                }
            }
        }
    }
}
