import UIKit
import Firebase
import PromiseKit

class FirebaseStorageService {
  static func uploadImage(image: UIImage) -> Promise<String> {
    return Promise { seal in
      let fileName = UUID().uuidString
      let imageRef = Storage.storage().reference(withPath: "/images/\(fileName)")
      let imageData = image.jpegData(compressionQuality: 0.75) ?? Data()
      
      imageRef.putData(imageData, metadata: nil) { _, error in
        if let error = error {
          seal.reject(error)
        }
        imageRef.downloadURL { url, error in
          if let error = error {
            seal.reject(error)
          }
          guard let url = url else { return }
          seal.fulfill(url.absoluteString)
        }
      }
    }
  }
}
