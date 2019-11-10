import UIKit

class CustomImagePickerController: UIImagePickerController {
  weak var sender: AnyObject?
  
  deinit {
    print("No leaks here")
  }
}
