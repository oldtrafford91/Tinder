import UIKit
import PromiseKit

class RegistrationViewModel {
  typealias Observer<T> = (T) -> ()
  
  // MARK: - Properties
  var buttonImage: UIImage? { didSet { onImageSelected(buttonImage) } }
  var fullnameInput: String? { didSet { checkFormValidity() } }
  var emailInput: String? { didSet { checkFormValidity() } }
  var passwordInput: String? { didSet { checkFormValidity() } }
  
  var onFormValidCheck: Observer<Bool> = { _ in }
  var onImageSelected: Observer<UIImage?> = { _ in }
  var onRegisteringStateChange: Observer<Bool> = { _ in }

  // MARK: Action
  private func checkFormValidity() {
    let isFormValid = fullnameInput.isNotEmpty() && emailInput.isNotEmpty() && passwordInput.isNotEmpty()
    onFormValidCheck(isFormValid)
  }
  
  func signup(completion: @escaping (Swift.Result<Void, Error>) -> ()){
    onRegisteringStateChange(true)
  
    firstly {
      FirebaseUserService.createUser(email: emailInput!, password: passwordInput!)
    }.then { user in
      FirebaseStorageService.uploadImage(image: self.buttonImage ?? UIImage())
    }.then { url in
      FirebaseUserService.saveUser(fullName: self.fullnameInput!, imageURL: url)
    }.done { _ in
      completion(.success(()))
    }.ensure {
      self.onRegisteringStateChange(false)
    }.catch { error in
      completion(.failure(error))
    }
  }
}


