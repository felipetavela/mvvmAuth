import Foundation
import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    var auth: Auth?
    
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var editprofileButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewView: UIView!
    
    @IBOutlet weak var profileView: UIView!
    override func viewDidLoad() {
        
        tableView.dataSource = self
        editprofileButton.layer.cornerRadius = 15
        profileImage.layer.cornerRadius = 90
        profileView.layer.cornerRadius = 10
        tableViewView.layer.cornerRadius = 10
    
        self.auth = Auth.auth()
        labelUsername.text = self.auth?.currentUser?.displayName
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell")
        
        return cell!
    }
}
