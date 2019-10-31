import UIKit

class RegistrationViewController: UIViewController {
  
  // MARK: - Subviews
  let selectPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Select Photo", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
    button.backgroundColor = .white
    button.setTitleColor(.black, for: .normal)
    button.layer.cornerRadius = 12
    button.heightAnchor.constraint(equalToConstant: 270).isActive = true
    return button
  }()
  
  let fullNameTextField: FormTextField = {
    let textField = FormTextField(padding: 24, height: 44)
    textField.placeholder = "Please enter your full name"
    return textField
  }()
  
  let emailTextField: FormTextField = {
    let textField = FormTextField(padding: 24, height: 44)
    textField.keyboardType = .emailAddress
    textField.placeholder = "Please enter your email"
    return textField
  }()
  
  let passwordTextField: FormTextField = {
    let textField = FormTextField(padding: 24, height: 44)
    textField.placeholder = "Please enter your password"
    textField.isSecureTextEntry = true
    textField.autocorrectionType = .no
    return textField
  }()
  
  let registerButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Register", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    button.backgroundColor = .init(white: 0, alpha: 0.3)
    button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    button.layer.cornerRadius = 22
    return button
  }()
  
  lazy var stackView = UIStackView(arrangedSubviews: [
    selectPhotoButton,
    fullNameTextField,
    emailTextField,
    passwordTextField,
    registerButton
  ])
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewHierachy()
    setupTapGesture()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Setup
  private func setupViewHierachy() {
    setupGradientLayer()
    setupContainerStackView()
    setupNotificationObservers()
  }
  
  private func setupContainerStackView() {
    view.addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 8
    stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
  }
  
  private func setupGradientLayer() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [#colorLiteral(red: 1, green: 0.3568627451, blue: 0.2156862745, alpha: 1).cgColor, #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1).cgColor ]
    gradientLayer.locations = [0.5, 1]
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
  
  // MARK: Action
  @objc private func handleKeyboardShowNotification(_ notification: Notification) {
    guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
      return
    }
    let keyboardFrame = value.cgRectValue
    let bottomSpace = view.frame.height - stackView.frame.height - stackView.frame.origin.y
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
}
