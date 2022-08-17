import Foundation
import Firebase

struct UserViewModel {
    let user: User
}

extension UserViewModel {
    
    init(_ user: User) {
        self.user = user
    }
}

extension UserViewModel {
    var email: String {
        return (Auth.auth().currentUser?.email)!
    }
    var username: String {
        return (Auth.auth().currentUser?.displayName)!
    }
    var photoURL: URL {
        return (Auth.auth().currentUser?.photoURL)!
    }
}
