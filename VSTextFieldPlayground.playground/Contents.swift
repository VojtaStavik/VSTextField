//: A UIKit based Playground to present user interface
  
import UIKit
import PlaygroundSupport

class myViewController : UIViewController {
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

PlaygroundPage.current.liveView = myViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
