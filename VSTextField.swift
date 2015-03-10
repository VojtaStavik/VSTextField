//
//  VSTextField.swift
//  Matic
//
//  Created by Vojta Stavik on 09/03/15.
//  Copyright (c) 2015 STRV. All rights reserved.
//

import UIKit

enum TextFieldFormatting {
    
    case SocialSecurityNumber
    case Default
}


class VSTextField: UITextField {

    
    /**
    Max lenght of input string. If 0 -> no limit.
    */
    var maxLenght = 0
    
    /**
    Type of text formatting
    */
    var formatting : TextFieldFormatting = .Default {
        
        didSet {
            
            if formatting == .SocialSecurityNumber {
                
                self.maxLenght = 11 // 9 digits + 2x "-"
            }
            
            else {
                
                self.maxLenght = 9
            }
        }
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

    
    // MARK - internal
    
    private var pureString: NSString = ""
    
    
    private func registerForNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: "UITextFieldTextDidChangeNotification", object: self)
    }
    
    
    func textDidChange() {
        
        if let textFieldString: NSString = self.text where formatting == .SocialSecurityNumber {
            
            pureString = textFieldString.stringByReplacingOccurrencesOfString("-", withString: "")
        
            var finalText = ""
            
            for i in 0...max(0, pureString.length - 1) {
                
                if i == 3 || i == 5 {
                    
                    finalText = finalText.stringByAppendingString("-")
                }
                
                if pureString.length > 0 {
                    
                    finalText = finalText.stringByAppendingString(pureString.substringWithRange(NSMakeRange(i, 1)))
                }
            }
            
            self.text = finalText
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
