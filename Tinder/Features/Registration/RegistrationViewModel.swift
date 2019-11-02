import UIKit

class RegistrationViewModel {
  typealias Observer<T> = (T) -> ()
  
  
  // MARK: - Properties
  var fullnameInput: String? { didSet {checkFormValidity()} }
  var emailInput: String? { didSet {checkFormValidity()} }
  var passwordInput: String? { didSet {checkFormValidity()} }
  
  var onFormValidCheck: Observer<Bool> = { _ in }
  
  // MARK: Action
  private func checkFormValidity() {
    let isFormValid = fullnameInput.isNotEmpty() && emailInput.isNotEmpty() && passwordInput.isNotEmpty()
    onFormValidCheck(isFormValid)
  }
  
}


