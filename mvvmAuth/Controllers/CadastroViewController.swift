//
//  ViewController.swift
//  mvvmAuth
//
//  Created by Felipe Tavela on 15/08/22.
//

import UIKit
import Firebase

class CadastroViewController: UIViewController {

    var auth: Auth?
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var senhaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = Auth.auth()
    }
    
    func alert (title: String, message: String) {
        
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(ok)
        
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func buttonAction(_ sender: Any) {
        
        let email: String = self.emailTextField.text ?? ""
        let senha: String = self.senhaTextField.text ?? ""
        
        if self.emailTextField.validateEmail() && self.senhaTextField.validatePassword() {}
        self.auth?.createUser(withEmail: email, password: senha, completion: { (result, error) in
            
            if error != nil {
                
                    self.alert(title: "Atencao", message: "Falha ao cadastrar")
            } else {
                self.alert(title: "Parabéns", message: "Cadastro concluído")
            }
        })
    }
    
}
extension UITextField {
    
    func validateEmail () -> Bool {
        
        let emailRegex = "[A-za-z0-9._%+-]+@[A-Za-z0-9.-]+.\\[A-Za-z]{2,64}"
        let validateRegex = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    
        return validateRegex.evaluate(with: self.text)
    }
    
    func validatePassword () -> Bool {
        
        let passwordRegex = ".{6,}"
        let validateRegex = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
    
        return validateRegex.evaluate(with: self.text)
    }
}
