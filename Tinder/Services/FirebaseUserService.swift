import Foundation
import PromiseKit
import Firebase

class FirebaseUserService {
  static func createUser(email: String, password: String) -> Promise<Firebase.User> {
    return Promise { seal in
      Auth.auth().createUser(withEmail: email, password: password) { result, error in
        if let error = error {
          seal.reject(error)
        }
        
        guard let user = result?.user else { return }
        seal.fulfill(user)
      }
    }
  }
  
  static func saveUser(fullName: String, imageURL: String) -> Promise<Void>{
    return Promise { seal in
      guard let userId = Auth.auth().currentUser?.uid else {
        return
      }
      let fullUserInfo: [String : Any] = ["uid": userId,
                                     "fullName": fullName,
                                       "images": [imageURL]
                                         ]
      Firestore.firestore().collection("users").document(userId).setData(fullUserInfo) { error in
        if let error = error {
          seal.reject(error)
        } else {
          seal.fulfill(())
        }
      }
    }
  }
}




