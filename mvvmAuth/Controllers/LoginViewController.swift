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
        
        emailTextField.tintColor = UIColor.clear
        senhaTextField.tintColor = UIColor.clear
        loginButton.layer.cornerRadius = 15
        emailView.layer.cornerRadius = 10
        senhaView.layer.cornerRadius = 10
        emailTextField.delegate = self
        senhaTextField.delegate = self
        
        self.auth = Auth.auth()
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
        
        self.auth?.signIn(withEmail: email, password: senha, completion: { (usuario, error)  in
            
            if error != nil {
print("Dados incorretos, tente novamente")
            }
            
            if usuario == nil {
                print("Tivemos um problema inesperado")
            }
            else {
                self.performSegue(withIdentifier: "toAuth", sender: self)
            }
        })
    }
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
}
