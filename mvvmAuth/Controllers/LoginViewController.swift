import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var senhaView: UIView!
    
    var auth:Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        emailTextField.autocapitalizationType = UITextAutocapitalizationType.none
        senhaTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        emailTextField.tintColor = UIColor.clear
        senhaTextField.tintColor = UIColor.clear
        loginButton.layer.cornerRadius = 15
        emailView.layer.cornerRadius = 10
        senhaView.layer.cornerRadius = 10
        emailTextField.delegate = self
        senhaTextField.delegate = self
        
        self.auth = Auth.auth()
        self.hideKeyboardWhenTappedAround() 
    }
    
    func alert (title: String, message: String) {
        
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(ok)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        let email: String = self.emailTextField.text ?? ""
        let senha: String = self.senhaTextField.text ?? ""
        
        switch (self.emailTextField.validateEmail(), self.senhaTextField.validatePassword()) {
            
        case (true, true):
            
            self.auth?.signIn(withEmail: email, password: senha, completion: { (usuario, error)  in
                 if error != nil {
                     self.alert(title: "Falha de login", message: "Falha ao conectar")
                 }
                 if usuario == nil {
                     self.alert(title: "Falha de login", message: "Usuário não encontrado")}
                 else {
                     let user = Auth.auth().currentUser
                     
                     if user?.displayName != nil {
                         self.performSegue(withIdentifier: "toDirectPerfil", sender: self)
                     } else{
                     self.performSegue(withIdentifier: "toAuth", sender: self)
                     }
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

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
