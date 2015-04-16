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
    case NoFormatting
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
    A character which will be replaced in formattingPattern by a number
    */
    var secureTextReplacementChar: Character = "\u{25cf}"
    
    
    /**
    Max lenght of input string. You don't have to set this if you set formattingPattern.
    If 0 -> no limit.
    */
    var maxLenght = 0
    
    
    /**
    Type of predefined text formatting. (You don't have to set this. It's more a future feature)
    */
    var formatting : TextFieldFormatting = .NoFormatting {
        
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
    Provides secure text entry but KEEPS formatting. All digits are replaced with the bullet character \u{25cf} .
    */
    var formatedSecureTextEntry: Bool {
        
        set {
            
            _formatedSecureTextEntry = newValue
            super.secureTextEntry = false
        }
        
        get {
            
            return _formatedSecureTextEntry
        }
    }
    
    
    override var text: String! {
        
        set {
            
            super.text = newValue
            textDidChange() // format string properly even when it's set programatically
        }
        
        get { return finalStringWithoutFormatting }
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
    
    /**
    Final text without formatting characters (read-only)
    */
    var finalStringWithoutFormatting : String {
        
        return VSTextField.makeOnlyDigitsString(_textWithoutSecureBullets)
    }
    
    
    // MARK: - class methods
    
    class func makeOnlyDigitsString(string: String) -> String {
        
        return join("", string.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet))
    }
    
    
    
    // MARK: - INTERNAL
    
    private var _formatedSecureTextEntry = false
    
    // if secureTextEntry is false, this value is similar to self.text
    // if secureTextEntry is true, you can find final formatted text without bullets here
    private var _textWithoutSecureBullets = ""
    
    
    private func registerForNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: "UITextFieldTextDidChangeNotification", object: self)
    }
    
    
    func textDidChange() {
        
        // TODO: - Isn't there more elegant way how to do this?
        let currentTextForFormatting: String
        
        if count(super.text) > count(_textWithoutSecureBullets) {
            
            currentTextForFormatting = _textWithoutSecureBullets + super.text.substringFromIndex(advance(super.text.startIndex, count(_textWithoutSecureBullets)))
        }
        
        else if count(super.text) == 0 {
         
            _textWithoutSecureBullets = ""
            currentTextForFormatting = ""
        }
        
        else {
            
            currentTextForFormatting = _textWithoutSecureBullets.substringToIndex(advance(_textWithoutSecureBullets.startIndex, count(super.text)))
        }
        
        
        if formatting != .NoFormatting && count(currentTextForFormatting) > 0 && count(formattingPattern) > 0 {
            
            let tempString = VSTextField.makeOnlyDigitsString(currentTextForFormatting)
            
            var finalText = ""
            var finalSecureText = ""
            
            var stop = false
            
            var formatterIndex = formattingPattern.startIndex
            var tempIndex = tempString.startIndex
            
            while !stop {
                
                let formattingPatternRange = Range(start: formatterIndex, end: advance(formatterIndex, 1) )
                
                if formattingPattern.substringWithRange(formattingPatternRange) != String(replacementChar) {
                    
                    finalText = finalText.stringByAppendingString(formattingPattern.substringWithRange(formattingPatternRange))
                    finalSecureText = finalSecureText.stringByAppendingString(formattingPattern.substringWithRange(formattingPatternRange))
                }
                    
                else if count(tempString) > 0 {
                    
                    let pureStringRange = Range(start: tempIndex, end: advance(tempIndex, 1))
                    
                    finalText = finalText.stringByAppendingString(tempString.substringWithRange(pureStringRange))
                    
                    // we want the last number to be visible
                    if advance(tempIndex, 1) == tempString.endIndex {
                        
                        finalSecureText = finalSecureText.stringByAppendingString(tempString.substringWithRange(pureStringRange))
                    }
                    
                    else {
                        
                        finalSecureText = finalSecureText.stringByAppendingString(String(secureTextReplacementChar))
                    }
                    
                    tempIndex++
                }
                
                formatterIndex++
                
                if formatterIndex >= formattingPattern.endIndex || tempIndex >= tempString.endIndex {
                    
                    stop = true
                }
            }
            
            _textWithoutSecureBullets = finalText
            super.text = _formatedSecureTextEntry ? finalSecureText : finalText
        }
        
        // Let's check if we have additional max length restrictions
        if maxLenght > 0 {
            
            if count(text) > maxLenght {
                
                super.text = text.substringToIndex(advance(text.startIndex, maxLenght))
                _textWithoutSecureBullets = _textWithoutSecureBullets.substringToIndex(advance(_textWithoutSecureBullets.startIndex, maxLenght))
            }
        }
    }
}
