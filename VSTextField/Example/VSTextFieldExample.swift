//
//  VSTextFieldExample.swift
//  VSTextField
//
//  Created by Dave Neff on 11/8/17.
//

import UIKit

class VSTextFieldExample: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    let textField = VSTextField()
    textField.backgroundColor = .yellow
    textField.textAlignment = .center
    textField.font = .preferredFont(forTextStyle: .headline)
    
    textField.formatting = .socialSecurityNumber
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(textField)
    
    textField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 1).isActive = true
    textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1).isActive = true
    textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
  }
  
}
