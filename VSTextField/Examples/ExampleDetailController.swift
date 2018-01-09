
//  VSTextField.swift
//  Created by Vojta Stavik
//  Copyright (c) 2016 www.vojtastavik.com All rights reserved.
//
//  Created by Dave Neff on 11/8/17.
//

import UIKit

final class ExampleDetailController: UIViewController {
    
    lazy var label = UILabel()
    private let textField = VSTextField()
    static let identifierForTesting = "VSTextField"
    
    init(formatting: TextFieldFormatting) {
        super.init(nibName: nil, bundle: nil)
        textField.formatting = formatting
        configureTextField()
        configureLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if textField.formatting == .custom {
            displayCustomFieldInputAlert()
        }
    }
    
    private func configureTextField() {
        textField.accessibilityIdentifier = ExampleDetailController.identifierForTesting

        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.font = .preferredFont(forTextStyle: .headline)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 1).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func configureLabel() {
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 1).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
    }
}

extension ExampleDetailController {
    private func displayCustomFieldInputAlert() {
        guard textField.formatting == .custom else { return }
        
        let alertController = UIAlertController(title: "Enter Custom Formatting", message: "Enter a custom VSTextField using the character `#` for what you'd like to replace.\nExample: (###) ###-####", preferredStyle: .alert)
        
        alertController.addTextField { tf in
            tf.placeholder = "(###) ###-####"
        }
        
        let saveAction = UIAlertAction(title: "Format", style: .default, handler: { _  in
            let inputField = alertController.textFields![0]
            self.textField.setFormatting(inputField.text ?? "", replacementChar: "#")
            self.textField.placeholder = inputField.text
            alertController.dismiss(animated: true)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alertController.dismiss(animated: false)
            self.navigationController?.popViewController(animated: true)
        })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
