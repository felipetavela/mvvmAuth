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
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.autocapitalizationType = UITextAutocapitalizationType.none
        senhaTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        emailView.layer.cornerRadius = 10
        passwordView.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 15
        
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
        
        switch (self.emailTextField.validateEmail(), self.senhaTextField.validatePassword()) {
            
        case (true, true):
            self.auth?.createUser(withEmail: email, password: senha, completion: { (result, error) in
                if error != nil {
                        self.alert(title: "Atencao", message: "Falha ao cadastrar")
                } else {
                    self.alert(title: "Parabéns", message: "Cadastro concluído")
                }
            })
            
        case (false, true):
            alert(title: "Erro", message: "Email inválido")
            
        case (true, false):
            alert(title: "Erro", message: "Senha inválida \n Min: 6 caracteres")
            
        case (false, false):
            alert(title: "Erro", message: "Digite email e senha válidos")
            
        }
        
}
}

extension CadastroViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
}


extension UITextField {
    
    func validateEmail () -> Bool {
        
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let validateRegex = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    
        return validateRegex.evaluate(with: self.text)
    }
    
    func validatePassword () -> Bool {
        
        let passwordRegex = ".{6,}"
        let validateRegex = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
    
        return validateRegex.evaluate(with: self.text)
    }
    
    func validateUsername () -> Bool {
        
        let usernameRegex = "[A-Za-z0-9._]{6,}"
        let validateRegex = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
    
        return validateRegex.evaluate(with: self.text)
    }
}
