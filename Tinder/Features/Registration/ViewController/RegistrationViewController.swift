import UIKit
import Firebase
import JGProgressHUD

class RegistrationViewController: UIViewController {
  
  // MARK: - Subviews
  private let selectPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Select Photo", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
    button.backgroundColor = .white
    button.setTitleColor(.black, for: .normal)
    button.layer.cornerRadius = 12
    button.imageView?.contentMode = .scaleAspectFill
    button.clipsToBounds = true
    button.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
    button.heightAnchor.constraint(equalToConstant: 270).isActive = true
    return button
  }()
  
  private let fullNameTextField: FormTextField = {
    let textField = FormTextField(padding: 24, height: 44)
    textField.placeholder = "Please enter your full name"
    textField.autocorrectionType = .no
    textField.autocapitalizationType = .allCharacters
    textField.addTarget(self, action: #selector(handleTextFieldChange(_:)), for: .editingChanged)
    return textField
  }()
  
  private let emailTextField: FormTextField = {
    let textField = FormTextField(padding: 24, height: 44)
    textField.keyboardType = .emailAddress
    textField.autocapitalizationType = .none
    textField.placeholder = "Please enter your email"
    textField.addTarget(self, action: #selector(handleTextFieldChange(_:)), for: .editingChanged)
    return textField
  }()
  
  private let passwordTextField: FormTextField = {
    let textField = FormTextField(padding: 24, height: 44)
    textField.placeholder = "Please enter your password"
    textField.addTarget(self, action: #selector(handleTextFieldChange(_:)), for: .editingChanged)
    textField.isSecureTextEntry = true
    textField.autocorrectionType = .no

    return textField
  }()
  
  private let registerButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Register", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setTitleColor(.gray, for: .disabled)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    button.backgroundColor = .lightGray
    button.isEnabled = false
    button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    button.layer.cornerRadius = 22
    button.addTarget(self, action: #selector(register), for: .touchUpInside)
    return button
  }()
  
  private let gradientLayer: CAGradientLayer = {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [#colorLiteral(red: 1, green: 0.3568627451, blue: 0.2156862745, alpha: 1).cgColor, #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1).cgColor ]
    gradientLayer.locations = [0.5, 1]
    return gradientLayer
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      fullNameTextField,
      emailTextField,
      passwordTextField,
      registerButton
    ])
    stackView.distribution = .fillEqually
    stackView.axis = .vertical
    stackView.spacing = 8
    return stackView
  }()
  
  private lazy var containerStackView = UIStackView(arrangedSubviews: [
    selectPhotoButton,
    stackView
  ])
  
  let registeringHUD = JGProgressHUD()
  
  // MARK: - Properties
  var viewModel = RegistrationViewModel()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewHierachy()
    setupTapGesture()
    setupViewModelBinding()
    
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    gradientLayer.frame = view.bounds
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNotificationObservers()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    if traitCollection.verticalSizeClass == .compact {
      containerStackView.axis = .horizontal
      containerStackView.distribution = .fillEqually
    } else {
      containerStackView.axis = .vertical
      containerStackView.distribution = .fill
    }

  }
  
  // MARK: - Setup
  private func setupViewHierachy() {
    setupGradientLayer()
    setupContainerStackView()
  }
  
  private func setupContainerStackView() {
    view.addSubview(containerStackView)
    containerStackView.axis = .vertical
    containerStackView.spacing = 8
    containerStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
    containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  private func setupGradientLayer() {
    view.layer.addSublayer(gradientLayer)
    gradientLayer.frame = view.bounds
  }
  
  private func setupNotificationObservers() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(handleKeyboardShowNotification(_:)),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(handleKeyboardHideNotification(_:)),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)
  }
  
  private func setupTapGesture() {
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
  }
  
  private func setupViewModelBinding() {
    viewModel.onFormValidCheck = { [weak self] isFormValid in
      guard let self = self else { return }
      self.registerButton.isEnabled = isFormValid
      if isFormValid {
        self.registerButton.backgroundColor = .init(white: 0, alpha: 0.1)
        self.registerButton.setTitleColor(.white, for: .normal)
      } else {
        self.registerButton.backgroundColor = .lightGray
        self.registerButton.setTitleColor(.gray, for: .normal)
      }
    }
    
    viewModel.onImageSelected = { [weak self] image in
      guard let self = self else { return }
      guard let image = image else { return }
      self.selectPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    viewModel.onRegisteringStateChange = { [weak self] isRegistering in
      guard let self = self else { return }
      if isRegistering {
        self.registeringHUD.textLabel.text = "Registering user"
        self.registeringHUD.show(in: self.view)
      } else {
        self.registeringHUD.dismiss()
      }
      
    }
  }
  
  // MARK: Action
  @objc private func handleKeyboardShowNotification(_ notification: Notification) {
    guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
      return
    }
    let keyboardFrame = value.cgRectValue
    let bottomSpace = view.frame.height - containerStackView.frame.height - containerStackView.frame.origin.y
    let difference = keyboardFrame.height - bottomSpace
    view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
  }
  
  @objc private func handleKeyboardHideNotification(_ notification: Notification) {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.view.transform = .identity
    })
  }
  
  @objc private func handleTapGesture() {
    view.endEditing(true)
  }
  
  @objc private func handleTextFieldChange(_ textField: UITextField) {
    if textField == fullNameTextField {
      viewModel.fullnameInput = textField.text
    } else if textField == emailTextField {
      viewModel.emailInput = textField.text
    } else if textField == passwordTextField {
      viewModel.passwordInput = textField.text
    }
  }
  
  @objc private func selectPhoto() {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.modalPresentationStyle = .fullScreen
    imagePicker.allowsEditing = true
    
    present(imagePicker, animated: true, completion: nil)
  }
  
  @objc private func register() {
    view.endEditing(true)
    viewModel.signup { (result) in
      switch result {
      case .success():
        print("Success sign up user")
      case .failure(let error):
        self.showHUDWithError(error as NSError)
      }
    }
  }
  
  // MARK: - Helpers
  private func showHUDWithError(_ error: NSError) {
    let hud = JGProgressHUD()
    hud.textLabel.text = "Failed registration"
    hud.detailTextLabel.text = error.localizedDescription + "Code: \(error.code)"
    hud.show(in: view)
    hud.dismiss(afterDelay: 4)
  }
}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    viewModel.buttonImage = image
    dismiss(animated: true)
  }
}
