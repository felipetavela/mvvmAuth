import Foundation
import UIKit
import Firebase

class PerfilViewController: UIViewController {
    
    var auth: Auth?
    
    @IBOutlet weak var labelUsername: UILabel!
    
    override func viewDidLoad() {
        
        self.auth = Auth.auth()
        labelUsername.text = self.auth?.currentUser?.displayName
        
    }
}
