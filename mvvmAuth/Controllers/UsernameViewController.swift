import Foundation
import UIKit
import Firebase
import FirebaseAuth

class UsernameViewController: UIViewController {
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameView.layer.cornerRadius = 10
        enterButton.layer.cornerRadius = 15
        self.hideKeyboardWhenTappedAround() 
    }
    
    func alert (title: String, message: String) {
        
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(ok)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func enterAction(_ sender: Any) {
        
        if self.usernameTextField.validateUsername() {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = usernameTextField.text
        changeRequest?.commitChanges { error in
            if error != nil {
                self.alert(title: "Erro", message: "Erro de sistema")
            } else {
                self.performSegue(withIdentifier: "toPerfil", sender: self)
            }
        }
    } else {
        self.alert(title: "Username inválido", message: "Requisitos: \n Mais de 6 caracteres \n Caracteres especiais permitidos: _.")

    }
}
}
