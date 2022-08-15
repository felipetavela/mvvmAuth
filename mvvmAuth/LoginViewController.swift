import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    var auth:Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = Auth.auth()
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
                print("Login feito com sucesso")
            }
        })
    }
}
