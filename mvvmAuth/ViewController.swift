//
//  ViewController.swift
//  mvvmAuth
//
//  Created by Felipe Tavela on 15/08/22.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var auth: Auth?
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var senhaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = Auth.auth()
    }

    @IBAction func buttonAction(_ sender: Any) {
        
        let email: String = self.emailTextField.text ?? ""
        let senha: String = self.senhaTextField.text ?? ""
        
        self.auth?.createUser(withEmail: email, password: senha, completion: { (result, error) in
            
            if error != nil {
                print("Falha ao cadastrar")
            } else {
                print("Sucesso ao cadastrar")
            }
        })
    }
    
}

